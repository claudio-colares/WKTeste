unit FPedidoVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  FListagemProdutos, Vcl.Mask, Vcl.DBCtrls, FireDAC.Comp.Client,
  ClienteController;

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
    dbeditDescricao: TDBEdit;
    dbeditQuantidade: TDBEdit;
    dbeditPrecoUnitario: TDBEdit;
    dbeditValorTotal: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btneditCodigoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btneditCodigoRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;

  var
    DBConexao        : TFDConnection;
   // ClienteController: TClienteController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
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

procedure TFrmPedidoVendaItem.btneditCodigoRightButtonClick(Sender: TObject);
begin
  try
    FrmListagemProdutos          := TFrmListagemProdutos.Create(self,DBConexao);
    FrmListagemProdutos.Position := poOwnerFormCenter;
    FrmListagemProdutos.ShowModal;
  finally
    FrmListagemProdutos.Free;
  end;
end;

constructor TFrmPedidoVendaItem.Create(AOwner: TComponent; AConnection: TFDConnection);
begin

  inherited Create(AOwner);
  DimencionarForm;
  DBConexao         := AConnection;
 // ClienteController := TClienteController.Create(DBConexao);
end;

procedure TFrmPedidoVendaItem.DimencionarForm;
begin
  Self.Position := poOwnerFormCenter;
  Self.Width    := 800;
  Self.Height   := 270;
end;

procedure TFrmPedidoVendaItem.FormShow(Sender: TObject);
begin
  btneditCodigo.SetFocus;
end;

end.
