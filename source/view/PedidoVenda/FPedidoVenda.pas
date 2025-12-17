{ -----------------------------------------------------------------------------------#
  # Projeto: wkTeste                                                                   #
  # Unit: FPredidoVenda                                                                #
  #                                                                                    #
  # Autor: Claudio Colares                                                             #
  # Data: 15/12/2025                                                                   #
  #                                                                                    #
  # Descrição:                                                                         #
  # Unit responsável pela tela de Pedido de Venda do sistema,                          #
  # realizando o controle de criação,# edição, carregamento e cancelamento de pedidos. #
  # Atua como interface entre o usuário e as regras de negócio,                        #
  # integrando-se aos Controllers e Models.                                            #
  #                                                                                    #
  # Principais funções:                                                                #
  # Gerenciamento da interface do Pedido de Venda.                                     #
  # Persistência e carregamento dos dados do pedido e seus itens.                      #
  # Integração com módulos de Cliente, Pedido de Venda e Itens.                        #
  # Comunicação com banco de dados MySQL via FireDAC.                                  #
  #                                                                                    #
  # Ambiente:                                                                          #
  # IDE: Delphi 12                                                                     #
  # Banco de Dados: MySQL                                                              #
  ------------------------------------------------------------------------------------- }

unit FPedidoVenda;

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
	btnFechar: TBitBtn;
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
	actAlterarItem: TAction;
	actExcluirItem: TAction;

	procedure FormShow(Sender: TObject);
	procedure btneditNumeroPedidoChange(Sender: TObject);
	procedure btneditCodigoClienteChange(Sender: TObject);
	procedure actInserirItemExecute(Sender: TObject);
	procedure FormCreate(Sender: TObject);
	procedure btneditCodigoClienteRightButtonClick(Sender: TObject);
	procedure btneditCodigoClienteExit(Sender: TObject);
	procedure btneditCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure actListagemClientesExecute(Sender: TObject);
	procedure btnGravarPedidoClick(Sender: TObject);
	procedure actCarregarPedidoVendaExecute(Sender: TObject);
	procedure actCancelarPedidoVendaExecute(Sender: TObject);
	procedure btnFecharClick(Sender: TObject);
	procedure actAlterarItemExecute(Sender: TObject);
	procedure dbgrdItensDblClick(Sender: TObject);
	procedure FormDestroy(Sender: TObject);
	procedure dbgrdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure actExcluirItemExecute(Sender: TObject);

  private
	{ Private declarations }

	procedure DimencionarForm;
	procedure LimparDadosCliente;
	procedure ExibirBotoes(aExibir: Boolean);
	procedure NovoPedidoVenda;
	procedure LimparDadosPedidoVenda;
	procedure TelaObterNumPedidoVenda(aTipo: TTipoPersistencia);
	procedure LimparGrid;

	function TipoPersistenciaDados(aNumPedido: Integer): TTipoPersistencia;
	function GravarPedidoVenda(aTipoPersistencia: TTipoPersistencia): Boolean;
	function TotalizarItens(DataSet: TDataSet): Currency;
	procedure AtualizarTotalPedido;

  var
	DBConexao     : TFDConnection;
	BaseDados     : TConectarBaseController;
	aIDVenda      : Integer;
	PersistirDados: TTipoPersistencia;

  public
	{ Public declarations }
	procedure ObterDadosCliente(aID: Integer);
	function ObterDadosPedidoVenda(aID: Integer): Boolean;
	procedure ObterItensPedidoVenda(nPedido: Integer);
	procedure ExcluirItemPedidoVenda(nCodigo: Integer);
	procedure ExcluirPedidoVenda(nCodigo: Integer);
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

uses FPedidoVendaItem, uFuncoesController, FListagemCliente, FListagenPedidoVenda, ClienteModel;

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.actListagemClientesExecute(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // EXIBIR LISTAGEM DO CADASTRO DE CLIENTES
  // ---------------------------------------------------------------------------
  try
	FrmListagemCliente          := TFrmListagemCliente.Create(Self, DBConexao);
	FrmListagemCliente.Position := poOwnerFormCenter;
	FrmListagemCliente.ShowModal;
  finally
	FrmListagemCliente.Free;
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.AtualizarTotalPedido;
begin
  editValorTotal.Text := FormatarMoeda(TotalizarItens(dbgrdItens.DataSource.DataSet));
end;

procedure TFrmPedidoVenda.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // GRAVAR OS DADOS NO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  if btneditCodigoCliente.Text = '' then
	Exit;

  if GravarPedidoVenda(TipoPersistenciaDados(aIDVenda)) then
  begin
	ShowMessage('Pedido salvo com sucesso!');
	NovoPedidoVenda;
  end
  else
	ShowMessage('ERRO!!' + sLineBreak + 'Não foi possível salvar o pedido!');
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.dbgrdItensDblClick(Sender: TObject);
begin
  if btneditCodigoCliente.Text = '' then
	Exit;
  actAlterarItem.Execute;
end;

procedure TFrmPedidoVenda.dbgrdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if btneditCodigoCliente.Text = '' then
	Exit;

  if Key = VK_RETURN then
	actAlterarItem.Execute;

  if Key = VK_DELETE then
    actExcluirItem.Execute;
end;

procedure TFrmPedidoVenda.TelaObterNumPedidoVenda(aTipo: TTipoPersistencia);
begin
  // ---------------------------------------------------------------------------
  // EXIBI A TELA PARA O USUARIO INSERIR O NUMERO DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  FrmCarregarPedidoVenda          := TFrmCarregarPedidoVenda.Create(Self, DBConexao, aTipo);
  FrmCarregarPedidoVenda.Position := poOwnerFormCenter;
  FrmCarregarPedidoVenda.ShowModal;
  // ---------------------------------------------------------------------------
end;

function TFrmPedidoVenda.TipoPersistenciaDados(aNumPedido: Integer): TTipoPersistencia;
begin
  // ---------------------------------------------------------------------------
  // CLASSIFICA O TIPO DE ALTERAÇÃO DO PEDIDO DE VENDA (NOVO OU EDIÇÃO)
  // ---------------------------------------------------------------------------
  if aNumPedido < 1 then
	Result := tpNovo
  else
	Result := tpAlterar;
  // ---------------------------------------------------------------------------
end;

function TFrmPedidoVenda.TotalizarItens(DataSet: TDataSet): Currency;
var
  Bookmark: TBookmark;
begin
  Result := 0;

  if not Assigned(dbgrdItens.DataSource) then
    Exit;

  DataSet := dbgrdItens.DataSource.DataSet;

  if not  DataSet.Active or DataSet.IsEmpty then
    Exit;

  Bookmark := DataSet.GetBookmark;
  try
    DataSet.DisableControls;
    DataSet.First;

    while not DataSet.Eof do
    begin
      Result := Result +
        DataSet.FieldByName('valor_total').AsCurrency;

      DataSet.Next;
    end;

  finally
    DataSet.GotoBookmark(Bookmark);
    DataSet.FreeBookmark(Bookmark);
    DataSet.EnableControls;
  end;
end;

procedure TFrmPedidoVenda.actAlterarItemExecute(Sender: TObject);
var
  nCodigo : Integer;
  nProduto: Integer;
begin
  // ---------------------------------------------------------------------------
  // EDIÇÃO DO ITEM DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  nCodigo  := QryPedidoVendaItens.FieldByName('codigo').AsInteger;
  nProduto := QryPedidoVendaItens.FieldByName('codigo_produto').AsInteger;

  FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(Self, DBConexao);
  FrmPedidoVendaItem.Position := poOwnerFormCenter;

  FrmPedidoVendaItem.ObterDadosItem(nCodigo, nProduto, aIDVenda);
  FrmPedidoVendaItem.GetNumeroPedidoVenda(aIDVenda);
  FrmPedidoVendaItem.GetNumeroPedidoVendaItem(nCodigo);
  FrmPedidoVendaItem.SetTipoPersistenciaItem(tpiAlterar);
  FrmPedidoVendaItem.ShowModal;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.actCancelarPedidoVendaExecute(Sender: TObject);
begin
  TelaObterNumPedidoVenda(tpCancelar);
end;

procedure TFrmPedidoVenda.actCarregarPedidoVendaExecute(Sender: TObject);
begin
  TelaObterNumPedidoVenda(tpCarregar);
end;

procedure TFrmPedidoVenda.actExcluirItemExecute(Sender: TObject);
var
  nCodigo: Integer;
begin
  // ---------------------------------------------------------------------------
  // EXCLUSAO DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  nCodigo := QryPedidoVendaItens.FieldByName('codigo').AsInteger;
  if MessageDlg('Deseja realmente excluir este item?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
	ExcluirItemPedidoVenda(nCodigo);
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // EXIBE A TELA PARA INSERSÃO DO ITEM NO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  if btneditCodigoCliente.Text = '' then
	Exit;
  try
	GravarPedidoVenda(TipoPersistenciaDados(aIDVenda));
	ObterDadosPedidoVenda(aIDVenda);

	FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(Self, DBConexao);
	FrmPedidoVendaItem.Position := poOwnerFormCenter;

	FrmPedidoVendaItem.GetNumeroPedidoVenda(aIDVenda);
	FrmPedidoVendaItem.SetTipoPersistenciaItem(tpiNovo);
	FrmPedidoVendaItem.ShowModal;
  finally
	FrmPedidoVendaItem.Free;
  end;
  // ---------------------------------------------------------------------------
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
  // ---------------------------------------------------------------------------
  // PREENCHE OS DADOS DO CLIENTE NA TELA DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  if btneditCodigoCliente.Text <> '' then
	ObterDadosCliente(StrToIntDef(btneditCodigoCliente.Text, 0))
  else
	LimparDadosCliente;
  // ---------------------------------------------------------------------------
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

procedure TFrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DBConexao);
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
  DimencionarForm;
  NovoPedidoVenda;
end;

function TFrmPedidoVenda.GravarPedidoVenda(aTipoPersistencia: TTipoPersistencia): Boolean;
var
  PedidoVenda          : TPedidoVendaModel;
  PedidoVendaController: TPedidoVendaController;
  vlrTotal             : Currency;
begin
  // ---------------------------------------------------------------------------
  // PERSISTIR DADOS DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  Result := false;
  try
	PedidoVendaController := TPedidoVendaController.Create(DBConexao);

	if aTipoPersistencia = tpNovo then
	  aIDVenda := PedidoVendaController.GetNumeroPedidoVenda + 1;

	PedidoVenda               := TPedidoVendaModel.Create;
	PedidoVenda.NumeroPedido  := aIDVenda;
	PedidoVenda.DataEmissao   := dateeditDataPedido.Date;
	PedidoVenda.CodigoCliente := StrToIntDef(btneditCodigoCliente.Text, 0);
	PedidoVenda.ValorTotal    := StrToIntDef(editValorTotal .Text, 0);

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
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.LimparDadosCliente;
begin
  // ---------------------------------------------------------------------------
  // lIMPA OS DADOS DO CLIENTE NO CABEÇALHO DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  btneditCodigoCliente.Text := '';
  editClienteNome.Clear;
  editClienteCidade.Clear;
  editClienteUF.Clear;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.LimparDadosPedidoVenda;
begin
  // ---------------------------------------------------------------------------
  // lIMPA OS DADOS DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  btneditNumeroPedido.Text   := '0';
  editValorTotal.Text := FormatarMoeda(0.00);
  dateeditDataPedido.Enabled := true;
  dateeditDataPedido.Date    := now;
  btneditCodigoCliente.SetFocus;
  LimparDadosCliente;
  LimparGrid;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.LimparGrid;
begin
  // ---------------------------------------------------------------------------
  // LIMPA OS DADOS DOS ITENS NO GRID
  // ---------------------------------------------------------------------------
  dbgrdItens.DataSource.DataSet.Close;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.NovoPedidoVenda;
begin
  // ---------------------------------------------------------------------------
  // INICIA UM NOVO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  aIDVenda := 0;
  TipoPersistenciaDados(aIDVenda);
  LimparDadosPedidoVenda;
  ExibirBotoes(true);
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.ObterDadosCliente(aID: Integer);
var
  Cliente          : TClienteModel;
  ClienteController: TClienteController;
begin
  // ---------------------------------------------------------------------------
  // CARREGA AS INFORMACOES DO CLIENTE
  // ---------------------------------------------------------------------------
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
  // ---------------------------------------------------------------------------
end;

function TFrmPedidoVenda.ObterDadosPedidoVenda(aID: Integer): Boolean;
var
  PedidoVenda          : TPedidoVendaModel;
  PedidoVendaController: TPedidoVendaController;
begin
  // ---------------------------------------------------------------------------
  // CARREGA OS DADOS DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------
  PedidoVendaController := TPedidoVendaController.Create(DBConexao);
  PedidoVenda           := PedidoVendaController.ObterDadosPedidoVenda(aID);

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
	// IMPORTACAO DOS ITENS DO PEDIDO DE VENDA
	aIDVenda := PedidoVenda.NumeroPedido;
	ObterItensPedidoVenda(aID);
	// --------------------------------------------------------------

	// ---------------------------------------------------------------------------
	// IMPORTACAO DOS DADOS DO CLIENTE PARA O CABEÇALHO DO PEDIDO DE VENDA
	ObterDadosCliente(PedidoVenda.CodigoCliente);
	// --------------------------------------------------------------

	Result := true;

  finally
	FreeAndNil(PedidoVenda);
	FreeAndNil(PedidoVendaController);
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmPedidoVenda.ObterItensPedidoVenda(nPedido: Integer);
var
  PedidoVendaItem          : TPedidoVendaItemModel;
  PedidoVendaItemController: TPedidoVendaItemController;
begin
  // ---------------------------------------------------------------------------
  // CARREGA OS DADOS ITENS DO PEDIDO DE VENDA
  // ---------------------------------------------------------------------------

  PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);

  PedidoVendaItem := TPedidoVendaItemModel.Create;
  try
	PedidoVendaItemController.CarregarItensPedidoVenda(nPedido, QryPedidoVendaItens);
    AtualizarTotalPedido;
  finally
	FreeAndNil(PedidoVendaItem);
	FreeAndNil(PedidoVendaItemController);
  end;
  // ---------------------------------------------------------------------------
end;


procedure TFrmPedidoVenda.ExcluirItemPedidoVenda(nCodigo: Integer);
var
  PedidoVendaItemController: TPedidoVendaItemController;
begin
  PedidoVendaItemController := TPedidoVendaItemController.Create(DBConexao);
  try

	if PedidoVendaItemController.DeletarItemPedidoVenda(nCodigo) then
	  ObterDadosPedidoVenda(aIDVenda)
	else
	  Exit;

  finally
	FreeAndNil(PedidoVendaItemController);
  end;
end;

procedure TFrmPedidoVenda.ExcluirPedidoVenda(nCodigo: Integer);
var
  PedidoVendaController: TPedidoVendaController;
begin
  PedidoVendaController := TPedidoVendaController.Create(DBConexao);
  try
	if PedidoVendaController.DeletarPedidoVenda(nCodigo) then
	begin
	  ShowMessage('Pedido excluído com successo!');
	  NovoPedidoVenda;
	end
	else
	  Exit;
  finally
	FreeAndNil(PedidoVendaController);
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
