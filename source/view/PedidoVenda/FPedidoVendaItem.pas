unit FPedidoVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  FListagemProdutos, Vcl.Mask, Vcl.DBCtrls, FireDAC.Comp.Client,
  ProdutosController, System.Actions, Vcl.ActnList, uConstantesController, FPedidoVenda;

type
  TTipoPersistenciaItem = (tpiNovo, tpiAlterar);

type
  TFrmPedidoVendaItem = class(TForm)
	pnlTitulo: TPanel;
	lblTitulo: TLabel;
	pnlBotoes: TPanel;
	GroupBox1: TGroupBox;
	btneditCodigo: TButtonedEdit;
	Label3: TLabel;
	Label4: TLabel;
	Label5: TLabel;
	Label6: TLabel;
	Label1: TLabel;
	btnConfirmar: TBitBtn;
	imgListPedidoVendaItem: TImageList;
	editDescricao: TEdit;
	editQuantidade: TEdit;
	editValorUnitario: TEdit;
	editValorTotal: TEdit;
	actlItemVenda: TActionList;
	actListagemProdutos: TAction;
	actFechar: TAction;
	procedure FormShow(Sender: TObject);
	procedure btneditCodigoChange(Sender: TObject);
	procedure btnConfirmarClick(Sender: TObject);
	procedure actListagemProdutosExecute(Sender: TObject);
	procedure btneditCodigoRightButtonClick(Sender: TObject);
	procedure btneditCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure FormCreate(Sender: TObject);
	procedure editQuantidadeExit(Sender: TObject);
	procedure btneditCodigoExit(Sender: TObject);
  private
	{ Private declarations }
	procedure DimencionarForm;
	procedure LimparTelaItemVenda;
	function GravarItemPedidoVenda(aNumeroPedido: Integer; aTipoPersistencia: TTipoPersistenciaItem): Boolean;
	procedure CalcularValorTotalItem;

  var
	DBConexao        : TFDConnection;
	ProdutoController: TProdutoController;
	aNumeroPedido    : Integer;
    aNumeroItem      : Integer;
	FTipoPersistencia: TTipoPersistenciaItem;
  public
	{ Public declarations }
	constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
	procedure ObterDadosProduto(aID: Integer);
	procedure GetNumeroPedidoVenda(nPedido: Integer);
    procedure GetNumeroPedidoVendaItem(nItem: Integer);
	procedure ObterDadosItem(nCodigo: Integer; nProduto: Integer; nPedido: Integer);
	procedure SetTipoPersistenciaItem(aTipoPersistenciaItem: TTipoPersistenciaItem);
  end;

var
  FrmPedidoVendaItem: TFrmPedidoVendaItem;

implementation

{$R *.dfm}

uses uFuncoesController, ProdutosModel, PedidoVendaItemModel, PedidoVendaItemController;
{ TFrmPedidoVendaItem }

procedure TFrmPedidoVendaItem.actListagemProdutosExecute(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // ABRE A TELA DE LISTAGEM DE PRODUTOS.
  // ---------------------------------------------------------------------------
  try
	FrmListagemProdutos          := TFrmListagemProdutos.Create(self, DBConexao);
	FrmListagemProdutos.Position := poOwnerFormCenter;
	FrmListagemProdutos.ShowModal;

	editQuantidade.SetFocus;
  finally
	FrmListagemProdutos.Free;
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVendaItem.btnConfirmarClick(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // GRAVAÇÃO (EDICAO OU NOVO REGISTRO) DO ITEM NO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  if GravarItemPedidoVenda(aNumeroPedido, FTipoPersistencia) = true then
  begin
	FrmPedidoVenda.ObterItensPedidoVenda(aNumeroPedido);
	LimparTelaItemVenda;
	btneditCodigo.SetFocus;
  end
  else
  begin
	ShowMessage('ERRO!!' + sLineBreak + 'Não foi possivél gravar o item no banco de dados.');
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVendaItem.btneditCodigoChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditCodigo);
end;

procedure TFrmPedidoVendaItem.btneditCodigoExit(Sender: TObject);
begin
  ObterDadosProduto(StrToIntDef(btneditCodigo.Text, 0));
end;

procedure TFrmPedidoVendaItem.btneditCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F8 then
	actListagemProdutos.Execute;
end;

procedure TFrmPedidoVendaItem.btneditCodigoRightButtonClick(Sender: TObject);
begin
  actListagemProdutos.Execute;
  CalcularValorTotalItem;
end;

procedure TFrmPedidoVendaItem.CalcularValorTotalItem;
var
  fQuantidade: Float32;
  vlrUnitario: Currency;
begin
  fQuantidade := StrToFloatDef(editQuantidade.Text, 0);
  vlrUnitario := StrToFloatDef(editValorUnitario.Text, 0);

  editValorTotal.Text := (vlrUnitario * fQuantidade).ToString;
end;

constructor TFrmPedidoVendaItem.Create(AOwner: TComponent; AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  DimencionarForm;
  DBConexao := AConnection;
end;

procedure TFrmPedidoVendaItem.DimencionarForm;
begin
  self.Position := poOwnerFormCenter;
  self.Width    := 800;
  self.Height   := 270;
end;

procedure TFrmPedidoVendaItem.editQuantidadeExit(Sender: TObject);
begin
  CalcularValorTotalItem;
end;

procedure TFrmPedidoVendaItem.FormCreate(Sender: TObject);
begin
  aNumeroPedido := 0;
end;

procedure TFrmPedidoVendaItem.FormShow(Sender: TObject);
begin
  if FTipoPersistencia = tpiNovo then
     LimparTelaItemVenda;
  btneditCodigo.SetFocus;
end;

procedure TFrmPedidoVendaItem.GetNumeroPedidoVenda(nPedido: Integer);
begin
  aNumeroPedido := nPedido;
end;

procedure TFrmPedidoVendaItem.GetNumeroPedidoVendaItem(nItem: Integer);
begin
  aNumeroItem := nItem;
end;

function TFrmPedidoVendaItem.GravarItemPedidoVenda(aNumeroPedido: Integer;
  aTipoPersistencia: TTipoPersistenciaItem): Boolean;
var
  PedidoVendaItem          : TPedidoVendaItemModel;
  PedidoVendaItemController: TPedidoVendaItemController;
begin
  // ---------------------------------------------------------------------------
  // GRAVA OS DADOS DO ITEM INFORMADO NO PEDIDO DE VENDA ATUAL.
  // ---------------------------------------------------------------------------
  Result := false;
  try
	PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);

	PedidoVendaItem               := TPedidoVendaItemModel.Create;
    PedidoVendaItem.Codigo        := aNumeroItem;
	PedidoVendaItem.NumeroPedido  := aNumeroPedido;
	PedidoVendaItem.CodigoProduto := StrToIntDef(btneditCodigo.Text, 0);
	PedidoVendaItem.Quantidade    := StrToFloatDef(editQuantidade.Text, 0);
	PedidoVendaItem.ValorUnitario := StrToFloatDef(editValorUnitario.Text, 0);
	PedidoVendaItem.ValorTotal    := StrToFloatDef(editValorTotal.Text, 0);

	if aTipoPersistencia = tpiNovo then
	  if PedidoVendaItemController.NovoItemPedidoVenda(PedidoVendaItem) then
		Result := true;

	if aTipoPersistencia = tpiAlterar then
	  if PedidoVendaItemController.AlterarItemPedidoVenda(PedidoVendaItem) then
		Result := true;

	LimparTelaItemVenda;
  finally
	FreeAndNil(PedidoVendaItem);
	FreeAndNil(PedidoVendaItemController);
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVendaItem.LimparTelaItemVenda;
begin
  btneditCodigo.Clear;
  editDescricao.Clear;
  editQuantidade.Text    := '1';
  editValorUnitario.Text := '0,00';
  CalcularValorTotalItem;
end;

procedure TFrmPedidoVendaItem.ObterDadosItem(nCodigo: Integer; nProduto: Integer; nPedido: Integer);
var
  PedidoVendaItem          : TPedidoVendaItemModel;
  PedidoVendaItemController: TPedidoVendaItemController;
begin
  // ---------------------------------------------------------------------------
  // PREENCHE OS CAMPOS NA TELA COM OS DADOS DO ITEM INFORMADO NO PEDIDO DE VENDA ATUAL.
  // ---------------------------------------------------------------------------
  if (nPedido < 1) or (nProduto < 1) then
	exit;

  PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);
  PedidoVendaItem           := PedidoVendaItemController.GetPedidoVendaItemByID(nCodigo,nPedido);

  try
	if PedidoVendaItem = nil then
	begin
	  ShowMessage('Item não encontrado.');
	  LimparTelaItemVenda;
	  btneditCodigo.SetFocus;
	  exit;
	end;

	btneditCodigo.Text     := PedidoVendaItem.CodigoProduto.ToString;
	editDescricao.Text     := PedidoVendaItem.DescricaoProduto;
	editQuantidade.Text    := PedidoVendaItem.Quantidade.ToString;
	editValorUnitario.Text := PedidoVendaItem.ValorUnitario.ToString;
	CalcularValorTotalItem;

  finally
	FreeAndNil(PedidoVendaItem);
	FreeAndNil(PedidoVendaItemController);
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVendaItem.ObterDadosProduto(aID: Integer);
var
  Produto          : TProdutoModel;
  ProdutoController: TProdutoController;
begin
  ProdutoController := TProdutoController.Create(DBConexao);
  Produto           := ProdutoController.ObterDadosProduto(aID);

  try
	if Produto = nil then
	begin
	  ShowMessage('Produto não encontrado.');
	  LimparTelaItemVenda;
	  btneditCodigo.SetFocus;
	  exit;
	end;

	btneditCodigo.Text := Produto.Codigo.ToString;
	editDescricao.Text := Produto.Descricao;
	if FTipoPersistencia = tpiNovo then
	  editQuantidade.Text  := '1';
	editValorUnitario.Text := Produto.PrecoVenda.ToString;
	CalcularValorTotalItem;

  finally
	FreeAndNil(Produto);
	FreeAndNil(ProdutoController);
  end;
end;

procedure TFrmPedidoVendaItem.SetTipoPersistenciaItem(aTipoPersistenciaItem: TTipoPersistenciaItem);
begin
  FTipoPersistencia := aTipoPersistenciaItem;
end;

end.
