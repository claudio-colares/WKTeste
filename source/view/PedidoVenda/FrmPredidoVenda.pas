unit FrmPredidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.Buttons;

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
    procedure FormShow(Sender: TObject);
    procedure btneditNumeroPedidoChange(Sender: TObject);
    procedure btneditCodigoClienteChange(Sender: TObject);
  private
    { Private declarations }
    procedure IniciarTela;
    procedure ExibirBotoesPesquisa(ButtonedEdit: TButtonedEdit);
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

{ TFrmPedidoVenda }

procedure TFrmPedidoVenda.btneditCodigoClienteChange(Sender: TObject);
begin
 ExibirBotoesPesquisa(btneditCodigoCliente);
end;

procedure TFrmPedidoVenda.btneditNumeroPedidoChange(Sender: TObject);
begin
  ExibirBotoesPesquisa(btneditNumeroPedido);
end;

procedure TFrmPedidoVenda.ExibirBotoesPesquisa(ButtonedEdit: TButtonedEdit);
begin
 if ButtonedEdit.Text = '' then
   ButtonedEdit.RightButton.Visible := True
 else
   ButtonedEdit.RightButton.Visible := False;
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
begin
 IniciarTela;
end;

procedure TFrmPedidoVenda.IniciarTela;
begin
 Self.Position := poScreenCenter;
 Self.Width    := 1024;
 Self.Height   := 768;
end;

end.
