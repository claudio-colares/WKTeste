unit PedidoVendaItemController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, PedidoVendaItemModel;

type
  TPedidoVendaItemController = class
  private
    PedidoVendaItemModel: TPedidoVendaItemModel;

  public
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosItem(aID: Integer);
  end;

implementation

{ TPedidoVendaItemController }

procedure TPedidoVendaItemController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaItemModel.CarregarTabela(aQuery);
end;

procedure TPedidoVendaItemController.ObterDadosItem(aID: Integer);
begin
  PedidoVendaItemModel.GetItemVendaByID(aID);
end;

end.
