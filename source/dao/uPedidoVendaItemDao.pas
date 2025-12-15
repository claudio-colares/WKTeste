unit uPedidoVendaItemDao;

interface

uses
  Data.DB, FireDAC.Comp.Client, ProdutosModel, PedidoVendaItemModel;

type
  TPedidoVendaItemDAO = class
  private
    DBConexao: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function GetPedidoVendaItemByID(ID: Integer): TPedidoVendaItemModel;
    function NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
    procedure CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);
    function AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
  end;

implementation

{ TPedidoVendaItemDAO }

function TPedidoVendaItemDAO.NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
var
  aQuery                : TFDQuery;
  strSQL                : String;
  aNumeroPedidoVenda    : Integer;
  aNovoNumeroPedidoVenda: Integer;
begin
  Result := False;
  // -------------------------------------------------------------------------
  // Novo item pedido
  // -------------------------------------------------------------------------
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := DBConexao;
    strSQL            :=
    'INSERT INTO pedidos_vendas_itens ' +
    '(numero_pedido, '+
    ' codigo_produto, '+
    ' quantidade, '+
    ' valor_unitario, '+
    ' valor_total) ' +
    'VALUES (:numero_pedido,:codigo_produto,:quantidade,:valor_unitario,:valor_total)';

    aQuery.SQL.Add(strSQL);
    aQuery.ParamByName('numero_pedido').AsInteger   := aPedidoVendaItemModel.NumeroPedido;
    aQuery.ParamByName('codigo_produto').AsInteger  := aPedidoVendaItemModel.CodigoProduto;
    aQuery.ParamByName('quantidade').AsFloat        := aPedidoVendaItemModel.Quantidade;
    aQuery.ParamByName('valor_unitario').AsCurrency := aPedidoVendaItemModel.ValorUnitario;
    aQuery.ParamByName('valor_total').AsCurrency    := aPedidoVendaItemModel.ValorTotal;

    aQuery.ExecSQL;
    aQuery.Connection.Commit;
    Result := true;
  finally
    aQuery.Free;
  end;
end;

procedure TPedidoVendaItemDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := DBConexao;
  aQuery.SQL.Text   :=
    'SELECT '+
    ' codigo,'+
    ' numero_pedido,'+
    ' codigo_produto,'+
    ' quantidade,'+
    ' valor_unitario,'+
    ' valor_total '+
    'FROM pedidos_vendas_itens';
  aQuery.Open;
end;

function TPedidoVendaItemDAO.AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
var
  aQuery                : TFDQuery;
  strSQL                : String;
  aNumeroPedidoVenda    : Integer;
begin
  Result := False;
  // -------------------------------------------------------------------------
  // Alterar item pedido de venda
  // -------------------------------------------------------------------------
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := DBConexao;
    strSQL :=
     'UPDATE pedidos_venda SET              '+
     '  data_emissao    = :data_emissao,    '+
     '  codigo_cliente  = :codigo_cliente,  '+
     '  valor_total     = :valor_total      '+
     'WHERE numero_pedido = :numero_pedido';
    aQuery.SQL.Add(strSQL);

    aQuery.ParamByName('numero_pedido').AsInteger   := aPedidoVendaItemModel.NumeroPedido;
    aQuery.ParamByName('codigo_produto').AsInteger  := aPedidoVendaItemModel.CodigoProduto;
    aQuery.ParamByName('quantidade').AsFloat        := aPedidoVendaItemModel.Quantidade;
    aQuery.ParamByName('valor_unitario').AsCurrency := aPedidoVendaItemModel.ValorUnitario;
    aQuery.ParamByName('valor_total').AsCurrency    := aPedidoVendaItemModel.ValorTotal;
    aQuery.ExecSQL;
    aQuery.Connection.Commit;
    Result := true;
  finally
    aQuery.Free;
  end;
  // -------------------------------------------------------------------------
end;

procedure TPedidoVendaItemDAO.CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);
var
 strSQL : String;
begin

  aQuery.Connection := DBConexao;
  strSQL   :=
   'SELECT ' +
    '  pvi.codigo,                           '+
    '  pvi.numero_pedido,                    '+
    '  pvi.codigo_produto,                   '+
    '  p.descricao AS nome_produto,          '+
    '  pvi.quantidade,                       '+
    '  pvi.valor_unitario,                   '+
    '  pvi.valor_total                       '+
    'FROM pedidos_vendas_itens pvi           '+
    'INNER JOIN produtos p 		     '+
    '  ON p.codigo = pvi.codigo_produto      '+
    'WHERE pvi.numero_pedido = :numero_pedido';

  aQuery.SQL.Text := strSQL;
  aQuery.ParamByName('numero_pedido').AsInteger := nPedido;

  aQuery.Open;
end;

constructor TPedidoVendaItemDAO.Create(aConnection: TFDConnection);
begin
  DBConexao := aConnection;
end;

function TPedidoVendaItemDAO.GetPedidoVendaItemByID(ID: Integer): TPedidoVendaItemModel;
var
  aQuery         : TFDQuery;
  PedidoVendaItem: TPedidoVendaItemModel;
begin

  aQuery := TFDQuery.Create(nil);
  try
    aQuery.Connection := DBConexao;
    aQuery.SQL.Text   :=
    'SELECT codigo,            '+
    ' numero_pedido,           '+
    ' codigo_produto,          '+
    ' quantidade,              '+
    ' valor_unitario,          '+
    ' valor_total              '+
    'FROM pedidos_vendas_itens '+
    'WHERE codigo = :ID';

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
