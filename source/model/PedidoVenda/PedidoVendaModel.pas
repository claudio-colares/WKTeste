unit PedidoVendaModel;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ClienteModel, FuncoesController,
  FPredidoVenda,
  system.SysUtils;

type
  TPedidoVendaModel = Record
    Codigo: Integer;
    DataEmissao: TDateTime;
    idCliente: Integer;
    vlrTotalPedido: Currency;
  private

  public
    procedure Limpar;
    procedure Dados(var aQuery: TFDQuery);
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure GetPedidoVendaByID(aID: Integer);
  end;

implementation

{ TPedidoVendaModel }

{ TPedidoVendaModel }

procedure TPedidoVendaModel.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.SQL.Text := 'SELECT numero_pedido, data_emissao, nome_cliente, valor_total FROM db_wkteste.vw_pedidos_venda;';
  aQuery.Open;
end;

procedure TPedidoVendaModel.Dados(var aQuery: TFDQuery);
begin
  Limpar;
end;

procedure TPedidoVendaModel.GetPedidoVendaByID(aID: Integer);
var
  aQuery: TFDQuery;
begin
 // QueryCriar(aQuery, FrmPedidoVenda.DBConexao);
  aQuery.SQL.Clear;
  aQuery.SQL.Add('SELECT codigo,descricao,precoVenda FROM produtos WHERE codigo = ' + IntToStr(aID));
  try
    aQuery.Open;

    if aQuery.IsEmpty then
      exit;

    Dados(aQuery);

  finally
    if aQuery <> nil then
      QueryLiberar(aQuery);
  end;
end;

procedure TPedidoVendaModel.Limpar;
begin
  Codigo         := 0;
  DataEmissao    := 01 / 01 / 2000;
  idCliente      := 0;
  vlrTotalPedido := 0;
end;

end.
