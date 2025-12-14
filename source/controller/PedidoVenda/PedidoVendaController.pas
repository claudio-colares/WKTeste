unit PedidoVendaController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, uPedidoVendaDao, PedidoVendaModel;

type
  TPedidoVendaController = class
  private
    PedidoVendaDao: TPedidoVendaDAO;

  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    procedure CarregarTabela(aQuery: TFDQuery);
    function ObterDadosPedidoVenda(aID: Integer): TPedidoVendaModel;
    procedure GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel);
  end;

implementation

{ TPedidoVendaController }

procedure TPedidoVendaController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaDao.CarregarTabela(aQuery);
end;

constructor TPedidoVendaController.Create(aConnection: TFDConnection);
begin
  PedidoVendaDao := TPedidoVendaDAO.Create(aConnection);
end;

destructor TPedidoVendaController.Destroy;
begin
  PedidoVendaDao.Free;
  inherited;
end;

procedure TPedidoVendaController.GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel);
begin
  PedidoVendaDao.GravarPedidoVenda(aPedidoVendaModel);
end;

function TPedidoVendaController.ObterDadosPedidoVenda(aID: Integer): TPedidoVendaModel;
begin
  result := PedidoVendaDao.GetPedidoVendaByID(aID);
end;

end.
