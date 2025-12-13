unit FListagemProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FBaseListagemCadastro, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, ProdutosController;

type
  TFrmListagemProdutos = class(TFrmCadastroBase)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelecionarClick(Sender: TObject);
  private
    { Private declarations }
  var
    DBConexao        : TFDConnection;
    ProdutoController: TProdutoController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
  end;

var
  FrmListagemProdutos: TFrmListagemProdutos;

implementation

{$R *.dfm}

uses FPedidoVendaItem;

procedure TFrmListagemProdutos.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  FrmPedidoVendaItem.ObterDadosProduto(QryCadastroBase.FieldByName('codigo').AsInteger);
end;

constructor TFrmListagemProdutos.Create(AOwner: TComponent; AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  DBConexao         := AConnection;
  ProdutoController := TProdutoController.Create(DBConexao);
end;

procedure TFrmListagemProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(ProdutoController);
end;

procedure TFrmListagemProdutos.FormShow(Sender: TObject);
begin
  inherited;
  try
    ProdutoController.CarregarTabela(QryCadastroBase);
  except
    on E: Exception do
      ShowMessage('Erro ao carregar lista de produtos: ' + E.Message);
  end;
end;

end.
