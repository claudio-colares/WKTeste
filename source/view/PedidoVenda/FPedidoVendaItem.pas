unit FPedidoVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  FListagemProdutos, Vcl.Mask, Vcl.DBCtrls, FireDAC.Comp.Client,
  ProdutosController, System.Actions, Vcl.ActnList, uConstantesController, FPredidoVenda;

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
    BitBtn1: TBitBtn;
    imgListPedidoVendaItem: TImageList;
    editDescricao: TEdit;
    editQuantidade: TEdit;
    editValorUnitario: TEdit;
    editValorTotal: TEdit;
    actlItemVenda: TActionList;
    actListagemProdutos: TAction;
    procedure FormShow(Sender: TObject);
    procedure btneditCodigoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure actListagemProdutosExecute(Sender: TObject);
    procedure btneditCodigoRightButtonClick(Sender: TObject);
    procedure btneditCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;
    procedure LimparDadosItemVenda;
    function InserirItemPedidoVenda(aNumeroPedido: Integer; aTipoPersistencia: TTipoPersistencia): Boolean;

  var
    DBConexao        : TFDConnection;
    ProdutoController: TProdutoController;
    aNumeroPedido    : Integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
    procedure ObterDadosProduto(aID: Integer);
    procedure GetNumeroPedidoVenda(nPedido: Integer);
  end;

var
  FrmPedidoVendaItem: TFrmPedidoVendaItem;

implementation

{$R *.dfm}

uses FuncoesController, ProdutosModel, PedidoVendaItemModel, PedidoVendaItemController;
{ TFrmPedidoVendaItem }

procedure TFrmPedidoVendaItem.actListagemProdutosExecute(Sender: TObject);
begin
  try
    FrmListagemProdutos          := TFrmListagemProdutos.Create(self, DBConexao);
    FrmListagemProdutos.Position := poOwnerFormCenter;
    FrmListagemProdutos.ShowModal;

    editQuantidade.SetFocus;
  finally
    FrmListagemProdutos.Free;
  end;
end;

procedure TFrmPedidoVendaItem.BitBtn1Click(Sender: TObject);
begin
  if InserirItemPedidoVenda(aNumeroPedido, tpNovo) = true then
  begin
    FrmPedidoVenda.ObterItensPedidoVenda(aNumeroPedido);
    LimparDadosItemVenda;
    btneditCodigo.SetFocus;
  end
  else
  begin
    ShowMessage('ERRO!!' + sLineBreak + 'Não foi possivél gravar o item no banco de dados.');
  end;
end;

procedure TFrmPedidoVendaItem.btneditCodigoChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditCodigo);
end;

procedure TFrmPedidoVendaItem.btneditCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F8 then
    actListagemProdutos.Execute;
end;

procedure TFrmPedidoVendaItem.btneditCodigoRightButtonClick(Sender: TObject);
begin
  actListagemProdutos.Execute;
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

procedure TFrmPedidoVendaItem.FormCreate(Sender: TObject);
begin
  aNumeroPedido := 0;
end;

procedure TFrmPedidoVendaItem.FormShow(Sender: TObject);
begin

  btneditCodigo.SetFocus;
end;

procedure TFrmPedidoVendaItem.GetNumeroPedidoVenda(nPedido: Integer);
begin
  aNumeroPedido := nPedido;
end;

function TFrmPedidoVendaItem.InserirItemPedidoVenda(aNumeroPedido: Integer;
  aTipoPersistencia: TTipoPersistencia): Boolean;
var
  PedidoVendaItem          : TPedidoVendaItemModel;
  PedidoVendaItemController: TPedidoVendaItemController;
begin
  Result := false;
  try
    PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);

    PedidoVendaItem               := TPedidoVendaItemModel.Create;
    PedidoVendaItem.NumeroPedido  := aNumeroPedido;
    PedidoVendaItem.CodigoProduto := strToIntDef(btneditCodigo.Text, 0);
    PedidoVendaItem.Quantidade    := StrToFloatDef(editQuantidade.Text, 0);
    PedidoVendaItem.ValorUnitario := StrToFloatDef(editValorUnitario.Text, 0);
    PedidoVendaItem.ValorTotal    := StrToFloatDef(editValorTotal.Text, 0);

    if aTipoPersistencia = tpNovo then
      if PedidoVendaItemController.NovoItemPedidoVenda(PedidoVendaItem) then
	Result := true;
    //
    // if aTipoPersistencia = tpAlterar then
    // if PedidoVendaController.AlterarPedidoVenda(PedidoVenda) then
    // Result := true;

  finally
    FreeAndNil(PedidoVendaItem);
    FreeAndNil(PedidoVendaItemController);
  end;
end;

procedure TFrmPedidoVendaItem.LimparDadosItemVenda;
begin
  btneditCodigo.Clear;
  editDescricao.Clear;

  editValorUnitario.Clear;
  editValorTotal.Clear;

end;

procedure TFrmPedidoVendaItem.ObterDadosProduto(aID: Integer);
var
  Produto: TProdutoModel;
begin
  ProdutoController := TProdutoController.Create(DBConexao);
  Produto           := ProdutoController.ObterDadosProduto(aID);

  try
    if Produto = nil then
    begin
      ShowMessage('Produto não encontrado.');
      LimparDadosItemVenda;
      btneditCodigo.SetFocus;
      Exit;
    end;

    btneditCodigo.Text := Produto.Codigo.ToString;
    editDescricao.Text := Produto.Descricao;

    editValorUnitario.Text := Produto.PrecoVenda.ToString;

  finally
    FreeAndNil(Produto);
    FreeAndNil(ProdutoController);
  end;
end;

end.
