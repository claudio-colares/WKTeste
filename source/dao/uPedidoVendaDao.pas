unit uPedidoVendaDao;

interface

uses
  Data.DB, FireDAC.Comp.Client, PedidoVendaModel, ClienteController, ClienteModel;

type
  TPedidoVendaDAO = class
  private
    DBConexao: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function GetPedidoVendaByID(ID: Integer): TPedidoVendaModel;
    function GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
    function AlterarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
    function GetNumeroPedidoVenda: Integer;
    function DeletarPedidoVenda(nCodigo: Integer): Boolean;
  end;

implementation

{ TPedidoVendaDAO }

function TPedidoVendaDAO.AlterarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
var
  aQuery                : TFDQuery;
  strSQL                : String;
  aNumeroPedidoVenda    : Integer;
  aNovoNumeroPedidoVenda: Integer;
begin
  Result := False;
  // -------------------------------------------------------------------------
  // Alterar pedido
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

    aQuery.ParamByName('numero_pedido').AsInteger  := aPedidoVendaModel.NumeroPedido;
    aQuery.ParamByName('data_emissao').AsDateTime  := aPedidoVendaModel.DataEmissao;
    aQuery.ParamByName('codigo_cliente').AsInteger := aPedidoVendaModel.CodigoCliente;
    aQuery.ParamByName('valor_total').AsCurrency   := aPedidoVendaModel.ValorTotal;
    aQuery.ExecSQL;
    Result := true;
  finally
    aQuery.Free;
  end;
end;

procedure TPedidoVendaDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := DBConexao;
  aQuery.SQL.Text   :=
  'SELECT numero_pedido, '+
  ' data_emissao,        '+
  ' codigo_cliente,      '+
  ' valor_total          '+
  'FROM pedidos_venda    '+
  'ORDER BY numero_pedido';
  aQuery.Open;
end;

constructor TPedidoVendaDAO.Create(aConnection: TFDConnection);
begin
  DBConexao := aConnection;
end;

function TPedidoVendaDAO.DeletarPedidoVenda(nCodigo: Integer): Boolean;
var
  strSQL: String;
  aQuery: TFDQuery;
begin
  Result := False;
  aQuery := TFDQuery.Create(nil);
  try
	Try
	  aQuery.Connection  := DBConexao;
	  aQuery.SQL.Text    := 'DELETE FROM pedidos_venda ' +
      					    'WHERE numero_pedido = :pCodigo';
	  aQuery.ParamByName('pCodigo').AsInteger := nCodigo;
	  aQuery.ExecSQL;
	  Result := true;
	except
	  Raise;
	End;
  finally
    aQuery.Free;
  end;
end;

function TPedidoVendaDAO.GetPedidoVendaByID(ID: Integer): TPedidoVendaModel;
var
  aQuery     : TFDQuery;
  PedidoVenda: TPedidoVendaModel;
begin
  aQuery := TFDQuery.Create(nil);
  try
    PedidoVenda := TPedidoVendaModel.Create;
    aQuery.Connection := DBConexao;
    aQuery.SQL.Text   :=
    'SELECT numero_pedido, '+
    ' data_emissao,        '+
    ' codigo_cliente,      '+
    ' valor_total          '+
    'FROM pedidos_venda    '+
    'WHERE numero_pedido = :ID';
    aQuery.ParamByName('ID').AsInteger := ID;
    aQuery.Open;

    if aQuery.IsEmpty then
      Exit(nil);

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
  aQuery                : TFDQuery;
  strSQL                : String;
  aNumeroPedidoVenda    : Integer;
  aNovoNumeroPedidoVenda: Integer;
begin
  Result := False;
  // -------------------------------------------------------------------------
  // Novo pedido
  // -------------------------------------------------------------------------
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := DBConexao;
    strSQL            := 'INSERT INTO pedidos_venda ' + '(numero_pedido, data_emissao, codigo_cliente, valor_total) ' +
      'VALUES (:numero_pedido, :data_emissao, :codigo_cliente, :valor_total)';

    aQuery.SQL.Add(strSQL);

    aQuery.ParamByName('numero_pedido').AsInteger  := aPedidoVendaModel.NumeroPedido;
    aQuery.ParamByName('data_emissao').AsDateTime  := aPedidoVendaModel.DataEmissao;
    aQuery.ParamByName('codigo_cliente').AsInteger := aPedidoVendaModel.CodigoCliente;
    aQuery.ParamByName('valor_total').AsCurrency   := aPedidoVendaModel.ValorTotal;
    aQuery.ExecSQL;
    Result := true;
  finally
    aQuery.Free;
  end;
end;

function TPedidoVendaDAO.GetNumeroPedidoVenda: Integer;
var
  aQuery: TFDQuery;
begin
  Result := 0;
  try
    aQuery            := TFDQuery.Create(nil);
    aQuery.Connection := DBConexao;
    aQuery.SQL.Add('SELECT MAX(numero_pedido ) AS ultimo_id FROM pedidos_venda');
    aQuery.Open;

    Result := aQuery.FieldByName('ultimo_id').AsInteger;
  finally
    aQuery.Free;
  end;
end;

// -------------------------------------------------------------------------
end.
