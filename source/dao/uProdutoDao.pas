unit uProdutoDAO;

interface

uses
  Data.DB, FireDAC.Comp.Client,ProdutosModel;

type
  TProdutoDAO = class
  private
    BDConexao : TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function  GetProdutoByID(ID: Integer): TProdutoModel;
  end;

implementation

{ TProdutoDAO }

procedure TProdutoDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := BDConexao;
  aQuery.SQL.Text := 'SELECT codigo, descricao, precoVenda FROM produtos';
  aQuery.Open;
end;

constructor TProdutoDAO.Create(aConnection: TFDConnection);
begin
 BDConexao := aConnection;
end;

function TProdutoDAO.GetProdutoByID(ID: Integer): TProdutoModel;
var
  aQuery: TFDQuery;
  Produto: TProdutoModel;
begin
  Produto := TProdutoModel.Create;
  aQuery := TFDQuery.Create(nil);
  try
    aQuery.Connection := BDConexao;
    aQuery.SQL.Text := 'SELECT codigo, descricao, precoVenda FROM produtos WHERE codigo = :ID';
    aQuery.ParamByName('ID').AsInteger := ID;
    aQuery.Open;

    if aQuery.IsEmpty then
      Exit(nil);

    Produto         := TProdutoModel.Create;
    Produto.Codigo  := aQuery.FieldByName('codigo').AsInteger;
    Produto.Descricao    := aQuery.FieldByName('descricao').AsString;
    Produto.PrecoVenda  := aQuery.FieldByName('precoVenda').AsCurrency;

    Result := Produto;
  finally
    aQuery.Free;
  end;
end;

end.

