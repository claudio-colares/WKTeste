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
    function  GetPedidoVendaItemByID(nCodigo:Integer; nProduto: Integer; nPedido:Integer): TPedidoVendaItemModel;
    function NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
    function AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
    function DeletarItemPedidoVenda(nCodigo: Integer): Boolean;
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

function TPedidoVendaItemController.DeletarItemPedidoVenda(nCodigo: Integer): Boolean;
begin
 result := DeletarItemPedidoVenda(nCodigo);
end;

destructor TPedidoVendaItemController.Destroy;
begin
  PedidoVendaItemDao.Free;
  inherited;
end;

function TPedidoVendaItemController.GetPedidoVendaItemByID(nCodigo: Integer; nProduto: Integer;nPedido:Integer) : TPedidoVendaItemModel;
begin
  result := PedidoVendaItemDao.GetPedidoVendaItemByID(nCodigo,nProduto,nPedido);
end;

end.
