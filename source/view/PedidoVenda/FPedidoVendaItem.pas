unit FPedidoVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TFrmPedidoVendaItem = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlBotoes: TPanel;
    GroupBox1: TGroupBox;
    btneditCodigo: TButtonedEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    editQuantidade: TEdit;
    Label6: TLabel;
    editVlrUnitario: TEdit;
    Label1: TLabel;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    imgListPedidoVendaItem: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btneditCodigoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;
  public
    { Public declarations }
  end;

var
  FrmPedidoVendaItem: TFrmPedidoVendaItem;

implementation

{$R *.dfm}

uses FuncoesController;
{ TFrmPedidoVendaItem }

procedure TFrmPedidoVendaItem.BitBtn1Click(Sender: TObject);
begin
 Self.Close;
end;

procedure TFrmPedidoVendaItem.btneditCodigoChange(Sender: TObject);
begin
  ExibirBotaoPesquisa(btneditCodigo);
end;

procedure TFrmPedidoVendaItem.DimencionarForm;
begin
  Self.Position := poOwnerFormCenter;
  Self.Width    := 800;
  Self.Height   := 270;
end;

procedure TFrmPedidoVendaItem.FormCreate(Sender: TObject);
begin
  DimencionarForm;
end;

procedure TFrmPedidoVendaItem.FormShow(Sender: TObject);
begin
  btneditCodigo.SetFocus;
end;

end.
