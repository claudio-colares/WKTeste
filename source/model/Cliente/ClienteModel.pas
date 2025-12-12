unit ClienteModel;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, System.SysUtils;

type
  TClienteModel = Record
    Codigo: Integer;
    Nome: String;
    Cidade: String;
    UF: String;
  private
    // Declarações Privada

  public
    // Declarações Publica
    procedure Limpar;
    procedure Dados(var aQuery: TFDQuery);
    procedure GetClienteByID(aID: Integer);
    procedure CarregarTabela(aQuery: TFDQuery);
  End;

implementation

{ TClienteModel }

uses FuncoesController, FPredidoVenda;


procedure TClienteModel.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.SQL.Text :=
    'SELECT Codigo, Nome, Cidade, UF FROM clientes';
  aQuery.Open;
end;


procedure TClienteModel.Dados(var aQuery: TFDQuery);
begin
  Limpar;
  Codigo := aQuery.FieldByName('codigo').AsInteger;
  Nome   := aQuery.FieldByName('nome').AsString;
  Cidade := aQuery.FieldByName('cidade').AsString;
  UF     := aQuery.FieldByName('uf').AsString;
end;

procedure TClienteModel.GetClienteByID(aID: Integer);
var
  aQuery: TFDQuery;
begin
  QueryCriar(aQuery, FrmPedidoVenda.DBConexao);
  aQuery.SQL.Clear;
  aQuery.SQL.Add('SELECT Codigo,Nome,Cidade,UF FROM clientes WHERE codigo = ' + IntToStr(aID));
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

procedure TClienteModel.Limpar;
begin
  Codigo := 0;
  Nome   := '';
  Cidade := '';
  UF     := '';
end;

end.
