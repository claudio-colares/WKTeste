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
  private
    { Private declarations }
    ProdutoController: TProdutoController;
  public
    { Public declarations }
  end;

var
  FrmListagemProdutos: TFrmListagemProdutos;

implementation

{$R *.dfm}

procedure TFrmListagemProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(ProdutoController);
end;

procedure TFrmListagemProdutos.FormShow(Sender: TObject);
begin
  inherited;
  try
    ProdutoController := TProdutoController.Create;
    ProdutoController.CarregarTabela(QryCadastroBase);
  except
    on E: Exception do
      ShowMessage('Erro ao carregar lista de produtos: ' + E.Message);
  end;
end;

end.
