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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListagemProdutos: TFrmListagemProdutos;
  ProdutoController    : TProdutoController;

implementation

{$R *.dfm}

procedure TFrmListagemProdutos.FormShow(Sender: TObject);
begin
  inherited;
  ProdutoController := TProdutoController.Create;
  ProdutoController.CarregarTabela(QryCadastroBase);
end;

end.
