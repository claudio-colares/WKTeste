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
  PedidoVendaController;

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
    btnCancelarPedido: TBitBtn;
    btnCarregarPedido: TBitBtn;
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

  private
    { Private declarations }
    procedure DimencionarForm;
    procedure LimparDadosCliente;
    procedure ExibirBotoes(aExibir: Boolean);

  var
    DBConexao: TFDConnection;
    BaseDados: TConectarBaseController;
  public
    { Public declarations }
    procedure ObterDadosCliente(aID: Integer);
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
var
  PedidoVenda          : TPedidoVendaModel;
  PedidoVendaController: TPedidoVendaController;
  NovoNumeroPedido     : Integer;
begin
  try
    PedidoVendaController     := TPedidoVendaController.Create(DBConexao);
    NovoNumeroPedido          := PedidoVendaController.GetNumeroPedidoVenda + 1;
    PedidoVenda               := TPedidoVendaModel.Create;
    PedidoVenda.NumeroPedido  := NovoNumeroPedido;
    PedidoVenda.DataEmissao   := dateeditDataPedido.Date;
    PedidoVenda.CodigoCliente := StrToIntDef(btneditCodigoCliente.Text, 0);
    PedidoVenda.ValorTotal    := StrToIntDef(editValorTotal.Text, 0);

    if PedidoVendaController.GravarPedidoVenda(PedidoVenda) then
    begin
      ShowMessage('Pedido salvo com sucesso!');
    end
    else
      ShowMessage('Erro ao salvar o pedido!');

  finally
    FreeAndNil(PedidoVenda);
    FreeAndNil(PedidoVendaController);
  end;
end;

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  try
    FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(Self, DBConexao);
    FrmPedidoVendaItem.Position := poOwnerFormCenter;
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
    LimparDadosCliente;
    ExibirBotoes(true);
    dateeditDataPedido.Enabled := false;
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
end;

procedure TFrmPedidoVenda.LimparDadosCliente;
begin
  editClienteNome.Clear;
  editClienteCidade.Clear;
  editClienteUF.Clear;
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

procedure TFrmPedidoVenda.DimencionarForm;
begin
  Self.Position := poScreenCenter;
  Self.Width    := 1024;
  Self.Height   := 768;
end;

procedure TFrmPedidoVenda.ExibirBotoes(aExibir: Boolean);
begin
  btnCancelarPedido.Visible := aExibir;
  btnCarregarPedido.Visible := aExibir;
end;

end.
