unit PedidoVendaItemController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, PedidoVendaItemModel;

type
  TPedidoVendaItemController = class
  private
    PedidoVendaItemModel: TPedidoVendaItemModel;

  public
    constructor Create;
    procedure CarregarTabela(aQuery: TFDQuery);
    procedure ObterDadosItem(aID: Integer);
  end;

implementation

{ TPedidoVendaItemController }

procedure TPedidoVendaItemController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaItemModel.CarregarTabela(aQuery);
end;

constructor TPedidoVendaItemController.Create;
begin
  PedidoVendaItemModel.Limpar;
end;

procedure TPedidoVendaItemController.ObterDadosItem(aID: Integer);
begin
  PedidoVendaItemModel.Limpar;
  PedidoVendaItemModel.GetItemVendaByID(aID);
end;

end.
