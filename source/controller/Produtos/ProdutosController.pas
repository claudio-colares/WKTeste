unit ProdutosController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  uProdutoDAO;

type
  TProdutoController = class
  private
    FProdutoDAO : TProdutoDAO;
  public
        constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosProduto(aID: Integer);
  end;

implementation

{ TClienteController }

procedure TProdutoController.CarregarTabela(aQuery: TFDQuery);
begin
  FProdutoDAO.CarregarTabela(aQuery);
end;

constructor TProdutoController.Create(aConnection: TFDConnection);
begin
  FProdutoDAO := TProdutoDAO.Create(aConnection);
end;

destructor TProdutoController.Destroy;
begin

  inherited;
end;

procedure TProdutoController.ObterDadosProduto(aID: Integer);
begin
 FProdutoDAO.GetProdutoByID(aID);
end;

end.
