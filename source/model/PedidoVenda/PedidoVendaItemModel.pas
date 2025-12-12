unit PedidoVendaItemModel;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, System.SysUtils;

type
  TPedidoVendaItemModel = Record
    Codigo        : Integer;
    NumeroPedido  : Integer;
    CodigoProduto : Integer;
    Quantidade    : Integer;
    ValorUnitario : Currency;
    ValorTotal    : Currency;
  private
    // Declarações Privada

  public
    // Declarações Publica
    procedure Limpar;
    procedure Dados(var aQuery: TFDQuery);
    procedure GetItemVendaByID(aID: Integer);
    procedure CarregarTabela(aQuery: TFDQuery);
  End;

implementation

{ TClienteModel }

uses FuncoesController, FPredidoVenda;


procedure TPedidoVendaItemModel.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.SQL.Text :=
    'SELECT codigo, descricao, precoVenda FROM produtos';
  aQuery.Open;
end;


procedure TPedidoVendaItemModel.Dados(var aQuery: TFDQuery);
begin
  Limpar;

end;

procedure TPedidoVendaItemModel.GetItemVendaByID(aID: Integer);
var
  aQuery: TFDQuery;
begin
  QueryCriar(aQuery, FrmPedidoVenda.DBConexao);
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

procedure TPedidoVendaItemModel.Limpar;
begin
    Codigo        := 0;
    NumeroPedido  := 0;
    CodigoProduto := 0;
    Quantidade    := 0;
    ValorUnitario := 0;
    ValorTotal    := 0;
end;

end.
