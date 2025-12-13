unit uPedidoVendaItemDAO;

interface

uses
  Data.DB, FireDAC.Comp.Client,ProdutosModel;

type
  TPedidoVendaItemDAO = class
  private
    BDConexao : TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function  GetPedidoVendaItemByID(ID: Integer): TProdutoModel;
  end;

implementation

{ TPedidoVendaItemDAO }

procedure TPedidoVendaItemDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := BDConexao;
  aQuery.SQL.Text := 'SELECT codigo, numero_pedido, codigo_produto,quantidade,valor_unitario,valor_total FROM pedidos_vendas_itens';
  aQuery.Open;
end;

constructor TPedidoVendaItemDAO.Create(aConnection: TFDConnection);
begin
 BDConexao := aConnection;
end;

function TPedidoVendaItemDAO.GetPedidoVendaItemByID(ID: Integer): TProdutoModel;
var
  aQuery: TFDQuery;
  Produto: TProdutoModel;
begin
  Produto := TProdutoModel.Create;
  aQuery := TFDQuery.Create(nil);
  try
    aQuery.Connection := BDConexao;
    aQuery.SQL.Text := 'SELECT codigo, numero_pedido, codigo_produto,quantidade,valor_unitario,valor_total '+
                       ' FROM pedidos_vendas_itens WHERE codigo = :ID';
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

