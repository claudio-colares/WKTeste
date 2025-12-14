unit uPedidoVendaItemDao;

interface

uses
  Data.DB, FireDAC.Comp.Client, ProdutosModel, PedidoVendaItemModel;

type
  TPedidoVendaItemDAO = class
  private
    BDConexao: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function GetPedidoVendaItemByID(ID: Integer): TPedidoVendaItemModel;
  end;

implementation

{ TPedidoVendaItemDAO }

procedure TPedidoVendaItemDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := BDConexao;
  aQuery.SQL.Text   :=
    'SELECT codigo, numero_pedido, codigo_produto,quantidade,valor_unitario,valor_total FROM pedidos_vendas_itens';
  aQuery.Open;
end;

constructor TPedidoVendaItemDAO.Create(aConnection: TFDConnection);
begin
  BDConexao := aConnection;
end;

function TPedidoVendaItemDAO.GetPedidoVendaItemByID(ID: Integer): TPedidoVendaItemModel;
var
  aQuery         : TFDQuery;
  PedidoVendaItem: TPedidoVendaItemModel;
begin

  aQuery := TFDQuery.Create(nil);
  try
    aQuery.Connection := BDConexao;
    aQuery.SQL.Text   := 'SELECT codigo, numero_pedido, codigo_produto,quantidade,valor_unitario,valor_total ' +
      ' FROM pedidos_vendas_itens WHERE codigo = :ID';
    aQuery.ParamByName('ID').AsInteger := ID;
    aQuery.Open;

    if aQuery.IsEmpty then
      Exit(nil);

    PedidoVendaItem               := TPedidoVendaItemModel.Create;
    PedidoVendaItem.Codigo        := aQuery.FieldByName('codigo').AsInteger;
    PedidoVendaItem.NumeroPedido  := aQuery.FieldByName('numero_pedido').AsInteger;
    PedidoVendaItem.CodigoProduto := aQuery.FieldByName('codigo_produto').AsInteger;
    PedidoVendaItem.Quantidade    := aQuery.FieldByName('quantidade').AsFloat;
    PedidoVendaItem.ValorUnitario := aQuery.FieldByName('valor_unitario').AsCurrency;
    PedidoVendaItem.ValorTotal    := aQuery.FieldByName('valor_total').AsCurrency;

    Result := PedidoVendaItem;
  finally
    aQuery.Free;
  end;
end;

end.
