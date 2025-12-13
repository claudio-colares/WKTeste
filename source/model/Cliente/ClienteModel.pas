unit ClienteModel;

interface

type
  TClienteModel = class
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;

    procedure Limpar;
  end;

implementation

{ TClienteModel }

procedure TClienteModel.Limpar;
begin
  FCodigo := 0;
  FNome := '';
  FCidade := '';
  FUF := '';
end;

end.

