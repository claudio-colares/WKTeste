unit ProdutosModel;

interface

type
  TProdutoModel = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Currency;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Currency read FPrecoVenda write FPrecoVenda;
    procedure Limpar;
  end;

implementation

{ TProdutoModel }

procedure TProdutoModel.Limpar;
begin
  FCodigo := 0;
  FDescricao := '';
  FPrecoVenda := 0;
end;

end.

