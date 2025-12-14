unit uClienteDAO;

interface

uses
  Data.DB, FireDAC.Comp.Client, ClienteModel;

type
  TClienteDAO = class
  private
    BDConexao: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);

    procedure CarregarTabela(aQuery: TFDQuery);
    function GetClienteByID(ID: Integer): TClienteModel;
    function Limpar: TClienteModel;
  end;

implementation

{ TClienteDAO }

procedure TClienteDAO.CarregarTabela(aQuery: TFDQuery);
begin
  aQuery.Connection := BDConexao;
  aQuery.SQL.Text   := 'SELECT Codigo, Nome, Cidade, UF FROM clientes';
  aQuery.Open;
end;

constructor TClienteDAO.Create(aConnection: TFDConnection);
begin
  BDConexao := aConnection;
end;

function TClienteDAO.GetClienteByID(ID: Integer): TClienteModel;
var
  aQuery : TFDQuery;
  Cliente: TClienteModel;
begin
  Cliente := TClienteModel.Create;
  aQuery  := TFDQuery.Create(nil);
  try
    aQuery.Connection                  := BDConexao;
    aQuery.SQL.Text                    := 'SELECT Codigo, Nome, Cidade, UF FROM clientes WHERE Codigo = :ID';
    aQuery.ParamByName('ID').AsInteger := ID;
    aQuery.Open;

    if aQuery.IsEmpty then
      Exit(nil);

    Cliente        := TClienteModel.Create;
    Cliente.Codigo := aQuery.FieldByName('Codigo').AsInteger;
    Cliente.Nome   := aQuery.FieldByName('Nome').AsString;
    Cliente.Cidade := aQuery.FieldByName('Cidade').AsString;
    Cliente.UF     := aQuery.FieldByName('UF').AsString;

    Result := Cliente;
  finally
    aQuery.Free;
  end;
end;

function TClienteDAO.Limpar: TClienteModel;
var
  Cliente: TClienteModel;
begin
  try
    Cliente        := TClienteModel.Create;
    Cliente.Codigo := 0;
    Cliente.Nome   := '';
    Cliente.Cidade := '';
    Cliente.UF     := '';
  finally
    Cliente.Free;
  end;
end;

end.
