unit PedidoVendaController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, PedidoVendaModel;

type
  TPedidoVendaController = class
  private
    PedidoVendaModel: TPedidoVendaModel;

  public
    constructor Create;
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosItem(aID: Integer);
  end;

implementation

{ TPedidoVendaController }

procedure TPedidoVendaController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaModel.CarregarTabela(aQuery);
end;

constructor TPedidoVendaController.Create;
begin
  PedidoVendaModel.Limpar;
end;

procedure TPedidoVendaController.ObterDadosItem(aID: Integer);
begin
  PedidoVendaModel.Limpar;
  PedidoVendaModel.GetPedidoVendaByID(aID);
end;

end.
