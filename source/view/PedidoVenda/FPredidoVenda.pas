unit FPredidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Mask, Vcl.DBCtrls, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  uConectarBaseController, uConstantesController, ClienteController, uPedidoVendaDao, PedidoVendaModel,
  PedidoVendaController, FCarregarPedidoVenda, PedidoVendaItemController, PedidoVendaItemModel;

type
  TFrmPedidoVenda = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlPrincipal: TPanel;
    pnlBotoes: TPanel;
    pnlCabecalhoPedido: TPanel;
    dbgrdItens: TDBGrid;
    imgListPrincipal: TImageList;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    btneditCodigoCliente: TButtonedEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    grpBoxDadosDoPedido: TGroupBox;
    Label1: TLabel;
    btneditNumeroPedido: TButtonedEdit;
    Label2: TLabel;
    dateeditDataPedido: TDateTimePicker;
    BitBtn1: TBitBtn;
    btnGravarPedido: TBitBtn;
    pnlgrid: TPanel;
    pnlBotoesItensPedido: TPanel;
    pnlTotalizador: TPanel;
    editValorTotal: TEdit;
    Label7: TLabel;
    actListPedidoVenda: TActionList;
    actInserirItem: TAction;
    editClienteNome: TEdit;
    editClienteCidade: TEdit;
    editClienteUF: TEdit;
    actListagemClientes: TAction;
    BitBtn3: TBitBtn;
    PnlBotoesPedidoVenda: TPanel;
    btnCancelarPedido: TBitBtn;
    btnCarregarPedido: TBitBtn;
    actCarregarPedidoVenda: TAction;
    actCancelarPedidoVenda: TAction;
    QryPedidoVendaItens: TFDQuery;
    dsPedidoVendaItens: TDataSource;
    FDConnection1: TFDConnection;

    procedure FormShow(Sender: TObject);
    procedure btneditNumeroPedidoChange(Sender: TObject);
    procedure btneditCodigoClienteChange(Sender: TObject);
    procedure actInserirItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btneditCodigoClienteRightButtonClick(Sender: TObject);
    procedure btneditNumeroPedidoRightButtonClick(Sender: TObject);
    procedure btneditCodigoClienteExit(Sender: TObject);
    procedure btneditCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actListagemClientesExecute(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure actCarregarPedidoVendaExecute(Sender: TObject);
    procedure actCancelarPedidoVendaExecute(Sender: TObject);

  private
    { Private declarations }

    procedure DimencionarForm;
    procedure LimparDadosCliente;
    procedure ExibirBotoes(aExibir: Boolean);
    procedure NovoPedidoVenda;
    procedure TelaObterNumPedidoVenda(aTipo: TTipoPersistencia);

    function TipoPersistenciaDados(aNumPedido: Integer): TTipoPersistencia;
    function GravarPedidoVenda(aTipoPersistencia: TTipoPersistencia): Boolean;
    procedure GarregarPedidoVenda(aTipo: TTipoPersistencia);

  var
    DBConexao         : TFDConnection;
    BaseDados         : TConectarBaseController;
    aIDVenda          : Integer;
    PersistirDados    : TTipoPersistencia;
  public
    { Public declarations }
    procedure ObterDadosCliente(aID: Integer);
    function ObterDadosPedidoVenda(aID: Integer): Boolean;
    procedure ObterItensPedidoVenda(nPedido: Integer);
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

uses FPedidoVendaItem, FuncoesController, FListagemCliente, FListagenPedidoVenda, ClienteModel;

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.actListagemClientesExecute(Sender: TObject);
begin
  try
    FrmListagemCliente          := TFrmListagemCliente.Create(Self, DBConexao);
    FrmListagemCliente.Position := poOwnerFormCenter;
    FrmListagemCliente.ShowModal;
  finally
    FrmListagemCliente.Free;
  end;
end;

procedure TFrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
begin
  if btneditCodigoCliente.Text = '' then
    Exit;

  if GravarPedidoVenda(TipoPersistenciaDados(aIDVenda)) then
  begin
    ShowMessage('Pedido salvo com sucesso!');
    NovoPedidoVenda;
  end
  else
    ShowMessage('ERRO!!' + sLineBreak + 'Não foi possível salvar o pedido!')
end;

procedure TFrmPedidoVenda.TelaObterNumPedidoVenda(aTipo: TTipoPersistencia);
begin
  try
    FrmCarregarPedidoVenda          := TFrmCarregarPedidoVenda.Create(Self, DBConexao, aTipo);
    FrmCarregarPedidoVenda.Position := poOwnerFormCenter;
    FrmCarregarPedidoVenda.ShowModal;
  finally
    FrmPedidoVendaItem.Free;
  end;
end;

function TFrmPedidoVenda.TipoPersistenciaDados(aNumPedido: Integer): TTipoPersistencia;
begin
  if aNumPedido < 1 then
    Result := tpNovo
  else
    Result := tpAlterar;
end;

procedure TFrmPedidoVenda.actCancelarPedidoVendaExecute(Sender: TObject);
begin
  TelaObterNumPedidoVenda(tpCancelar);
end;

procedure TFrmPedidoVenda.actCarregarPedidoVendaExecute(Sender: TObject);
begin
  TelaObterNumPedidoVenda(tpCarregar);
end;

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  if btneditCodigoCliente.Text = '' then
    Exit;
  try
    GravarPedidoVenda(TipoPersistenciaDados(aIDVenda));
    ObterDadosPedidoVenda(aIDVenda);

    FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(Self, DBConexao);
    FrmPedidoVendaItem.Position := poOwnerFormCenter;
    FrmPedidoVendaItem.GetNumeroPedidoVenda(aIDVenda);
    FrmPedidoVendaItem.ShowModal;
  finally
    FrmPedidoVendaItem.Free;
  end;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditCodigoCliente);

  if btneditCodigoCliente.Text = '' then
  begin
    NovoPedidoVenda;
  end
  else
  begin
    ExibirBotoes(false);
    dateeditDataPedido.Enabled := true;
  end;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteExit(Sender: TObject);
begin
  if btneditCodigoCliente.Text <> '' then
    ObterDadosCliente(StrToIntDef(btneditCodigoCliente.Text, 0))
  else
    LimparDadosCliente;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F8 then
    actListagemClientes.Execute;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteRightButtonClick(Sender: TObject);
begin
  actListagemClientes.Execute;
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditNumeroPedido);
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoRightButtonClick(Sender: TObject);
begin
  // try
  // FrmListagemPedidoVenda          :=  TFrmListagemPedidoVenda.Create(nil);
  // FrmListagemPedidoVenda.Position := poOwnerFormCenter;
  // FrmListagemPedidoVenda.ShowModal;
  // finally
  // FrmListagemPedidoVenda.Free;
  // end;
end;


procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  // -------------------------------------------------------------------------
  // CONEXAO COM O BANCO DE DADOS
  // -------------------------------------------------------------------------
  DBConexao := TFDConnection.Create(nil);
  SetConstantes;
  if not BaseDados.Conectar(DBConexao) then
  begin
    ShowMessage('FALHA NA CONEXÃO!' + sLineBreak + sLineBreak + 'Análise o arquivo de configuração.' + sLineBreak +
      _PATH_SISTEMA + _ARQUIVO_INI);
    Application.Terminate;
  end;
  // -------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
  DimencionarForm;
  NovoPedidoVenda;
end;

procedure TFrmPedidoVenda.GarregarPedidoVenda(aTipo: TTipoPersistencia);
begin
  //
end;

function TFrmPedidoVenda.GravarPedidoVenda(aTipoPersistencia: TTipoPersistencia): Boolean;
var
  PedidoVenda          : TPedidoVendaModel;
  PedidoVendaController: TPedidoVendaController;
begin
  Result := false;
  try
    PedidoVendaController := TPedidoVendaController.Create(DBConexao);

    if aTipoPersistencia = tpNovo then
      aIDVenda := PedidoVendaController.GetNumeroPedidoVenda + 1;

    PedidoVenda               := TPedidoVendaModel.Create;
    PedidoVenda.NumeroPedido  := aIDVenda;
    PedidoVenda.DataEmissao   := dateeditDataPedido.Date;
    PedidoVenda.CodigoCliente := StrToIntDef(btneditCodigoCliente.Text, 0);
    PedidoVenda.ValorTotal    := StrToIntDef(editValorTotal.Text, 0);

    if aTipoPersistencia = tpNovo then
      if PedidoVendaController.GravarPedidoVenda(PedidoVenda) then
	Result := true;

    if aTipoPersistencia = tpAlterar then
      if PedidoVendaController.AlterarPedidoVenda(PedidoVenda) then
	Result := true;

  finally
    FreeAndNil(PedidoVenda);
    FreeAndNil(PedidoVendaController);
  end;
end;

procedure TFrmPedidoVenda.LimparDadosCliente;
begin
  btneditCodigoCliente.Text := '';
  editClienteNome.Clear;
  editClienteCidade.Clear;
  editClienteUF.Clear;
end;

procedure TFrmPedidoVenda.NovoPedidoVenda;
begin
  aIDVenda := 0;
  TipoPersistenciaDados(aIDVenda);
  btneditNumeroPedido.Text   := aIDVenda.ToString;
  dateeditDataPedido.Enabled := true;
  ExibirBotoes(true);
  LimparDadosCliente;
  btneditCodigoCliente.SetFocus;
end;

procedure TFrmPedidoVenda.ObterDadosCliente(aID: Integer);
var
  Cliente          : TClienteModel;
  ClienteController: TClienteController;
begin
  ClienteController := TClienteController.Create(DBConexao);
  Cliente           := ClienteController.ObterClientePorID(aID);
  try
    if Cliente = nil then
    begin
      ShowMessage('Cliente não encontrado.');
      LimparDadosCliente;
      btneditCodigoCliente.SetFocus;
      Exit;
    end;

    btneditCodigoCliente.Text := Cliente.Codigo.ToString;
    editClienteNome.Text      := Cliente.Nome;
    editClienteCidade.Text    := Cliente.Cidade;
    editClienteUF.Text        := Cliente.UF;

  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
  end;
end;

function TFrmPedidoVenda.ObterDadosPedidoVenda(aID: Integer): Boolean;
var
  PedidoVenda          : TPedidoVendaModel;
  PedidoVendaController: TPedidoVendaController;
begin

  PedidoVendaController := TPedidoVendaController.Create(DBConexao);

  PedidoVenda := TPedidoVendaModel.Create;
  PedidoVenda := PedidoVendaController.ObterDadosPedidoVenda(aID);

  try
    if PedidoVenda = nil then
    begin
      ShowMessage('Pedido não encontrado.');
      Result := false;
      NovoPedidoVenda;
      Exit;
    end;

    btneditNumeroPedido.Text  := PedidoVenda.NumeroPedido.ToString;
    btneditCodigoCliente.Text := PedidoVenda.CodigoCliente.ToString;
    dateeditDataPedido.Date   := PedidoVenda.DataEmissao;
    editValorTotal.Text       := PedidoVenda.ValorTotal.ToString;

    // --------------------------------------------------------------
    // Impeplentar para trazer todos os dados do pedido
    // --------------------------------------------------------------
    ObterItensPedidoVenda(PedidoVenda.NumeroPedido);
    Result := true;

  finally
    FreeAndNil(PedidoVenda);
    FreeAndNil(PedidoVendaController);
  end;
end;

procedure TFrmPedidoVenda.ObterItensPedidoVenda(nPedido: Integer);
var
  PedidoVendaItem          : TPedidoVendaItemModel;
  PedidoVendaItemController: TPedidoVendaItemController;
begin

  PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);

  PedidoVendaItem := TPedidoVendaItemModel.Create;
  try
    PedidoVendaItemController.CarregarItensPedidoVenda(nPedido, QryPedidoVendaItens);

  finally
    FreeAndNil(PedidoVendaItem);
    FreeAndNil(PedidoVendaItemController);
  end;
end;

procedure TFrmPedidoVenda.DimencionarForm;
begin
  Self.Position := poScreenCenter;
  Self.Width    := 1024;
  Self.Height   := 768;
end;

procedure TFrmPedidoVenda.ExibirBotoes(aExibir: Boolean);
begin
  PnlBotoesPedidoVenda.Visible := aExibir;
end;

end.
