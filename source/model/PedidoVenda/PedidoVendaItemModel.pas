unit PedidoVendaItemModel;

interface

type
  TPedidoVendaItemModel = class
  private
    FCodigo: Integer;
    FNumeroPedido : Integer;
    FCodigoProduto: Integer;
    FQuantidade   : Float32;
    FValorUnitario: Currency;
    FValorTotal   : Currency;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Float32 read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal   : currency read FValorTotal write FValorTotal;
    procedure Limpar;
  end;

implementation

{ TProdutoModel }

procedure TPedidoVendaItemModel.Limpar;
begin
    FCodigo       := 0;
    FNumeroPedido := 0;
    FCodigoProduto:= 0;
    FQuantidade   := 0;
    FValorUnitario:= 0;
    FValorTotal   := 0;
end;

end.

