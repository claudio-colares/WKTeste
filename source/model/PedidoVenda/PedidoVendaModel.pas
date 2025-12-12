unit PedidoVendaModel;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ClienteModel;

type
  TPedidoVendaModel = Record
   Codigo         : Integer;
   DataEmissao    : TDateTime;
   idCliente      : Integer;
   vlrTotalPedido : Currency;
  private

  public
    procedure Limpar;
    procedure CarregarTabela(aQuery: TFDQuery);
  end;

implementation
{ TPedidoVendaModel }


{ TPedidoVendaModel }

procedure TPedidoVendaModel.CarregarTabela(aQuery: TFDQuery);
begin
   aQuery.SQL.Text :=
    'SELECT numero_pedido, data_emissao, codigo_cliente, valor_total FROM pedidos_venda';
  aQuery.Open;
end;

procedure TPedidoVendaModel.Limpar;
begin
   Codigo         := 0;
   DataEmissao    := 01/01/2000;
   idCliente      := 0;
   vlrTotalPedido := 0;
end;

end.
