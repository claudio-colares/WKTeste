unit ProdutosController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ProdutosModel;

type
  TProdutoController = class
  private
    ProdutoModel: TProdutoModel;
  public
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosProduto(aID: Integer);
  end;

implementation

{ TClienteController }

procedure TProdutoController.CarregarTabela(aQuery: TFDQuery);
begin
  ProdutoModel.CarregarTabela(aQuery);
end;

procedure TProdutoController.ObterDadosProduto(aID: Integer);
begin
 ProdutoModel.GetProdutoByID(aID);
end;

end.
