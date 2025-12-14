unit uPedidoVendaDao;

interface

uses
  Data.DB, FireDAC.Comp.Client, PedidoVendaModel;

type
  TPedidoVendaDAO = class
  private
    BDConexao: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function GetPedidoVendaByID(ID: Integer): TPedidoVendaModel;
    function GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
    function GetNumeroPedidoVenda: Integer;
  end;

implementation

{ TPedidoVendaDAO }

procedure TPedidoVendaDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := BDConexao;
  aQuery.SQL.Text   := 'SELECT numero_pedido, data_emissao, codigo_cliente,valor_total FROM pedidos_venda';
  aQuery.Open;
end;

constructor TPedidoVendaDAO.Create(aConnection: TFDConnection);
begin
  BDConexao := aConnection;
end;

function TPedidoVendaDAO.GetPedidoVendaByID(ID: Integer): TPedidoVendaModel;
var
  aQuery     : TFDQuery;
  PedidoVenda: TPedidoVendaModel;
begin
  PedidoVenda := TPedidoVendaModel.Create;
  aQuery      := TFDQuery.Create(nil);
  try
    aQuery.Connection := BDConexao;
    aQuery.SQL.Text   := 'SELECT numero_pedido, data_emissao, codigo_cliente,valor_total ' +
      ' FROM pedidos_vendas WHERE numero_pedido = :ID';
    aQuery.ParamByName('ID').AsInteger := ID;
    aQuery.Open;

    if aQuery.IsEmpty then
      Exit(nil);

    PedidoVenda               := TPedidoVendaModel.Create;
    PedidoVenda.NumeroPedido  := aQuery.FieldByName('numero_pedido').AsInteger;
    PedidoVenda.DataEmissao   := aQuery.FieldByName('data_emissao').AsDateTime;
    PedidoVenda.CodigoCliente := aQuery.FieldByName('codigo_cliente').AsInteger;
    PedidoVenda.ValorTotal    := aQuery.FieldByName('valor_total').AsCurrency;

    Result := PedidoVenda;
  finally
    aQuery.Free;
  end;
end;

function TPedidoVendaDAO.GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
var
  aQuery: TFDQuery;
  strSQL: String;
  aNumeroPedidoVenda : Integer;
  aNovoNumeroPedidoVenda: Integer;
begin
  Result := False;
  // -------------------------------------------------------------------------
  // Novo pedido
  // -------------------------------------------------------------------------
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := BDConexao;
    strSQL            := 'INSERT INTO pedidos_venda ' +
    			 '(numero_pedido, data_emissao, codigo_cliente, valor_total) ' +
                         'VALUES (:numero_pedido, :data_emissao, :codigo_cliente, :valor_total)';

    aQuery.SQL.Add(strSQL);
    aQuery.ParamByName('numero_pedido').AsInteger  := aPedidoVendaModel.NumeroPedido;
    aQuery.ParamByName('data_emissao').AsDateTime  := aPedidoVendaModel.DataEmissao;
    aQuery.ParamByName('codigo_cliente').AsInteger := aPedidoVendaModel.CodigoCliente;
    aQuery.ParamByName('valor_total').AsCurrency   := aPedidoVendaModel.ValorTotal;
    aQuery.ExecSQL;
    aQuery.Connection.Commit;
    Result := true;
  finally
    aQuery.Free;
  end;

end;

function TPedidoVendaDAO.GetNumeroPedidoVenda: Integer;
var
 aQuery : TFDQuery;
begin
  result := 0;
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := BDConexao;
    aQuery.SQL.Add('SELECT MAX(numero_pedido ) AS ultimo_id FROM pedidos_venda');
    aQuery.Open;

    Result := aQuery.FieldByName('ultimo_id').AsInteger;
  finally
    aQuery.Free;
  end;
end;

// -------------------------------------------------------------------------
end.
