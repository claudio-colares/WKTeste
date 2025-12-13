unit FPedidoVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  FListagemProdutos, Vcl.Mask, Vcl.DBCtrls, FireDAC.Comp.Client,
  ProdutosController;

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
    procedure FormShow(Sender: TObject);
    procedure btneditCodigoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btneditCodigoRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DimencionarForm;
    procedure LimparDadosItemVenda;

  var
    DBConexao        : TFDConnection;
    ProdutoController: TProdutoController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
    procedure ObterDadosProduto(aID: Integer);
  end;

var
  FrmPedidoVendaItem: TFrmPedidoVendaItem;

implementation

{$R *.dfm}

uses FuncoesController, ProdutosModel;
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

procedure TFrmPedidoVendaItem.LimparDadosItemVenda;
begin
  btneditCodigo.Clear;
  editDescricao.Clear;
  editQuantidade.Clear;
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
