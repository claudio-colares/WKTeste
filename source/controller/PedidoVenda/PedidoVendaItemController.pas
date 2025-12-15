unit PedidoVendaItemController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, uPedidoVendaItemDao, PedidoVendaItemModel;

type
  TPedidoVendaItemController = class
  private
    PedidoVendaItemDao: TPedidoVendaItemDAO;

  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    procedure CarregarTabela(aQuery: TFDQuery);
    function  GetPedidoVendaItemByID(aID: Integer): TPedidoVendaItemModel;
    function NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
    function AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
    procedure CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);
  end;

implementation

{ TPedidoVendaItemController }

function TPedidoVendaItemController.NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
begin
  result := PedidoVendaItemDao.NovoItemPedidoVenda(aPedidoVendaItemModel);
end;

function TPedidoVendaItemController.AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
begin
  result := PedidoVendaItemDao.AlterarItemPedidoVenda(aPedidoVendaItemModel);
end;

procedure TPedidoVendaItemController.CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);
begin
  PedidoVendaItemDao.CarregarItensPedidoVenda(nPedido,aQuery);
end;

procedure TPedidoVendaItemController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaItemDao.CarregarTabela(aQuery);
end;

constructor TPedidoVendaItemController.Create(aConnection: TFDConnection);
begin
 PedidoVendaItemDao := TPedidoVendaItemDao.Create(aConnection);
end;

destructor TPedidoVendaItemController.Destroy;
begin
  PedidoVendaItemDao.Free;
  inherited;
end;

function TPedidoVendaItemController.GetPedidoVendaItemByID(aID: Integer) : TPedidoVendaItemModel;
begin
  result := PedidoVendaItemDao.GetPedidoVendaItemByID(aID);
end;

end.
