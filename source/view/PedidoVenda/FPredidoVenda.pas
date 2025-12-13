unit FPredidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Mask, Vcl.DBCtrls, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  uConectarBaseController, uConstantesController, ClienteController;

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
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pnlgrid: TPanel;
    BitBtn6: TBitBtn;
    pnlBotoesItensPedido: TPanel;
    pnlTotalizador: TPanel;
    Edit4: TEdit;
    Label7: TLabel;
    actListPedidoVenda: TActionList;
    actInserirItem: TAction;
    QryPedidoVenda: TFDQuery;
    QryPedidoVendaItem: TFDQuery;
    dsPedidoVenda: TDataSource;
    dsPedidoVendaItem: TDataSource;
    editClienteNome: TEdit;
    editClienteCidade: TEdit;
    editClienteUF: TEdit;
    Button1: TButton;

    procedure FormShow(Sender: TObject);
    procedure btneditNumeroPedidoChange(Sender: TObject);
    procedure btneditCodigoClienteChange(Sender: TObject);
    procedure actInserirItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btneditCodigoClienteRightButtonClick(Sender: TObject);
    procedure btneditNumeroPedidoRightButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
    procedure DimencionarForm;
  var
  DBConexao : TFDConnection;
  ClienteController   : TClienteController;
  BaseDados           : TConectarBaseController;

  public
    { Public declarations }
  end;

var
  FrmPedidoVenda      : TFrmPedidoVenda;

implementation

{$R *.dfm}

uses FPedidoVendaItem, FuncoesController, FListagemCliente, FListagenPedidoVenda, ClienteModel;

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  try
    FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(Self,DBConexao);
    FrmPedidoVendaItem.Position := poOwnerFormCenter;
    FrmPedidoVendaItem.ShowModal;
  finally
    FrmPedidoVendaItem.Free;
  end;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditCodigoCliente);
end;

procedure TFrmPedidoVenda.btneditCodigoClienteRightButtonClick(Sender: TObject);
begin
  try
    FrmListagemCliente          := TFrmListagemCliente.Create(Self,DBConexao);
    FrmListagemCliente.Position := poOwnerFormCenter;
    FrmListagemCliente.ShowModal;
  finally
    FrmListagemCliente.Free;
  end;
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditNumeroPedido);
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoRightButtonClick(Sender: TObject);
begin
   try
    FrmListagemPedidoVenda          :=  TFrmListagemPedidoVenda.Create(nil);
    FrmListagemPedidoVenda.Position := poOwnerFormCenter;
    FrmListagemPedidoVenda.ShowModal;
  finally
    FrmListagemPedidoVenda.Free;
  end;
end;

procedure TFrmPedidoVenda.Button1Click(Sender: TObject);
var
  Cliente: TClienteModel;
begin
  ClienteController := TClienteController.Create(DBConexao);
  Cliente      := ClienteController.ObterClientePorID(strToIntDef(btneditCodigoCliente.Text,0));
  try
    if Cliente = nil then
    begin
      ShowMessage('Cliente não encontrado.');
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

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  DBConexao := TFDConnection.Create(nil);
  SetConstantes;
  if not BaseDados.Conectar(DBConexao) then
  begin
    ShowMessage('FALHA NA CONEXÃO!' + sLineBreak + sLineBreak + 'Análise o arquivo de configuração.' + sLineBreak +
      _PATH_SISTEMA + _ARQUIVO_INI);
    Application.Terminate;
  end;
end;


procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
  DimencionarForm;
  btneditNumeroPedido.SetFocus;
end;

procedure TFrmPedidoVenda.DimencionarForm;
begin
  Self.Position := poScreenCenter;
  Self.Width    := 1024;
  Self.Height   := 768;
end;

end.
