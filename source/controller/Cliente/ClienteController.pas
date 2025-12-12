unit ClienteController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ClienteModel;

type
  TClienteController = class
  private
    ClienteModel: TClienteModel;
  public
    constructor Create;
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosCliente(aID: Integer);
  end;

implementation

{ TClienteController }

procedure TClienteController.CarregarTabela(aQuery: TFDQuery);
begin
  ClienteModel.CarregarTabela(aQuery);
end;

constructor TClienteController.Create;
begin
 ClienteModel.Limpar;
end;

procedure TClienteController.ObterDadosCliente(aID: Integer);
begin
 ClienteModel.Limpar;
 ClienteModel.GetClienteByID(aID);
end;

end.
