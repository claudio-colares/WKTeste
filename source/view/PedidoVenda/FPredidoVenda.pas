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
    DBConexao: TFDConnection;
    dsPedidoVenda: TDataSource;
    dsPedidoVendaItem: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    QryClientes: TFDQuery;
    FDQuery2: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure btneditNumeroPedidoChange(Sender: TObject);
    procedure btneditCodigoClienteChange(Sender: TObject);
    procedure actInserirItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btneditCodigoClienteRightButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btneditNumeroPedidoRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;

  public
    { Public declarations }
  end;

var
  FrmPedidoVenda      : TFrmPedidoVenda;
  BaseDados           : TConectarBase;
  ClienteController   : TClienteController;
implementation

{$R *.dfm}

uses FPedidoVendaItem, FuncoesController, FListagemCliente, FListagenPedidoVenda;

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  try
    FrmPedidoVendaItem          := TFrmPedidoVendaItem.Create(nil);
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
    FrmListagemCliente          := TFrmListagemCliente.Create(nil);
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

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  SetConstantes;
  BaseDados.AcessarBase(DBConexao);

  try
    DBConexao.Open;
  except
    on E: Exception do
    begin
      ShowMessage('FALHA NA CONEXÃO!' + sLineBreak + sLineBreak + 'Análise o arquivo de configuração.' + sLineBreak +
	_PATH_SISTEMA + _ARQUIVO_INI);
      Application.Terminate;
    end;

  end;
end;

procedure TFrmPedidoVenda.FormDestroy(Sender: TObject);
begin
 if ClienteController <> nil then
   ClienteController.Free;
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
  DimencionarForm;
  QryPedidoVenda.Active     := true;
  QryPedidoVendaItem.Active := true;
end;

procedure TFrmPedidoVenda.DimencionarForm;
begin
  Self.Position := poScreenCenter;
  Self.Width    := 1024;
  Self.Height   := 768;
end;

end.
