unit ProdutosController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ProdutosModel;

type
  TProdutoController = class
  private
    ProdutoModel: TProdutoModel;
  public
    constructor Create;
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosProduto(aID: Integer);
  end;

implementation

{ TClienteController }

procedure TProdutoController.CarregarTabela(aQuery: TFDQuery);
begin
  ProdutoModel.CarregarTabela(aQuery);
end;

constructor TProdutoController.Create;
begin
 ProdutoModel.Limpar;
end;

procedure TProdutoController.ObterDadosProduto(aID: Integer);
begin
 ProdutoModel.Limpar;
 ProdutoModel.GetProdutoByID(aID);
end;

end.
