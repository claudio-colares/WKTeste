unit FPredidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList;

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
    Edit1: TEdit;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
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
    procedure FormShow(Sender: TObject);
    procedure btneditNumeroPedidoChange(Sender: TObject);
    procedure btneditCodigoClienteChange(Sender: TObject);
    procedure actInserirItemExecute(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

uses FPedidoVendaItem, FuncoesController;

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.actInserirItemExecute(Sender: TObject);
begin
  try
    FrmPedidoVendaItem := TFrmPedidoVendaItem.Create(nil);
    FrmPedidoVendaItem.ShowModal;
  finally
    FrmPedidoVendaItem.Free;
  end;
end;

procedure TFrmPedidoVenda.btneditCodigoClienteChange(Sender: TObject);
begin
 ExibirBotaoPesquisa(btneditCodigoCliente);
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoChange(Sender: TObject);
begin
 ExibirBotaoPesquisa(btneditNumeroPedido);
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
 DimencionarForm;
end;

procedure TFrmPedidoVenda.DimencionarForm;
begin
 Self.Position := poScreenCenter;
 Self.Width    := 1024;
 Self.Height   := 768;
end;

end.
