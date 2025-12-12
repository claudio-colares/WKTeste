unit ClienteController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, ClienteModel;

type
  TClienteController = class
  private
    ClienteModel: TClienteModel;
  public
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosCliente(aID: Integer);
  end;

implementation

{ TClienteController }

procedure TClienteController.CarregarTabela(aQuery: TFDQuery);
begin
   ClienteModel.CarregarTabela(aQuery);
end;

procedure TClienteController.ObterDadosCliente(aID: Integer);
begin
   ClienteModel.GetClienteByID(aID);
end;

end.
