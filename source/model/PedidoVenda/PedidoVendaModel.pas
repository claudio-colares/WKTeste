unit PedidoVendaModel;

interface

type
  TPedidoVendaModel = class
  private
    FNumeroPedido : Integer;
    FDataEmissao  : TDateTime;
    FCodigoCliente: Integer;
    FValorTotal   : Currency;

  public
    property Codigo: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao : TDateTime read FDataEmissao write FDataEmissao;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal   : currency read FValorTotal write FValorTotal;
    procedure Limpar;
  end;

implementation

{ TProdutoModel }

procedure TPedidoVendaModel.Limpar;
begin
    FNumeroPedido := 0;
    FDataEmissao  := 2000-01-01;
    FCodigoCliente:= 0;
    FValorTotal   := 0;
end;

end.

