unit ClienteController;

interface

uses
  ClienteModel, Data.DB, FireDAC.Comp.Client, uClienteDao;

type
  TClienteController = class
  private
    FClienteDAO: TClienteDAO;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    procedure CarregarTabela(Qry: TFDQuery);
    function ObterClientePorID(ID: Integer): TClienteModel;
    function Limpar : TClienteModel;
  end;

implementation

{ TClienteController }

constructor TClienteController.Create(aConnection: TFDConnection);
begin
  FClienteDAO := TClienteDAO.Create(aConnection);
end;

destructor TClienteController.Destroy;
begin
  FClienteDAO.Free;
  inherited;
end;

function TClienteController.Limpar:TClienteModel;
begin
  Result := FClienteDAO.Limpar;
end;

procedure TClienteController.CarregarTabela(Qry: TFDQuery);
begin
  FClienteDAO.CarregarTabela(Qry);
end;

function TClienteController.ObterClientePorID(ID: Integer): TClienteModel;
begin
  Result := FClienteDAO.GetClienteByID(ID);
end;

end.
