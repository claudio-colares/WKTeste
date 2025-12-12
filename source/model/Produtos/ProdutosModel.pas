unit ProdutosModel;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, System.SysUtils;

type
  TProdutoModel = Record
    Codigo     : Integer;
    Descricao   : String;
    PrecoVenda : Currency;
  private
    // Declarações Privada

  public
    // Declarações Publica
    procedure Limpar;
    procedure Dados(var aQuery: TFDQuery);
    procedure GetProdutoByID(aID: Integer);
    procedure CarregarTabela(aQuery: TFDQuery);
  End;

implementation

{ TClienteModel }

uses FuncoesController, FPredidoVenda;


procedure TProdutoModel.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.SQL.Text :=
    'SELECT codigo, descricao, precoVenda FROM produtos';
  aQuery.Open;
end;


procedure TProdutoModel.Dados(var aQuery: TFDQuery);
begin
  Limpar;
  Codigo     := aQuery.FieldByName('codigo').AsInteger;
  Descricao  := aQuery.FieldByName('descricao').AsString;
  PrecoVenda := aQuery.FieldByName('precoVenda').AsCurrency;
end;

procedure TProdutoModel.GetProdutoByID(aID: Integer);
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

procedure TProdutoModel.Limpar;
begin
  Codigo     := 0;
  Descricao  := '';
  PrecoVenda := 0;
end;

end.
