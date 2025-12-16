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
    function GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
    function AlterarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
    function GetNumeroPedidoVenda: Integer;
    function DeletarPedidoVenda(nCodigo: Integer): Boolean;
  end;

implementation

{ TPedidoVendaController }

function TPedidoVendaController.AlterarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
begin
  result := PedidoVendaDao.AlterarPedidoVenda(aPedidoVendaModel);
end;

procedure TPedidoVendaController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaDao.CarregarTabela(aQuery);
end;

constructor TPedidoVendaController.Create(aConnection: TFDConnection);
begin
  PedidoVendaDao := TPedidoVendaDAO.Create(aConnection);
end;

function TPedidoVendaController.DeletarPedidoVenda(nCodigo: Integer): Boolean;
begin
 result := PedidoVendaDao.DeletarPedidoVenda(nCodigo);
end;

destructor TPedidoVendaController.Destroy;
begin
  PedidoVendaDao.Free;
  inherited;
end;

function TPedidoVendaController.GetNumeroPedidoVenda: Integer;
begin
 Result := PedidoVendaDao.GetNumeroPedidoVenda;
end;

function TPedidoVendaController.GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel):Boolean;
begin
  result := PedidoVendaDao.GravarPedidoVenda(aPedidoVendaModel);
end;

function TPedidoVendaController.ObterDadosPedidoVenda(aID: Integer): TPedidoVendaModel;
begin
  result := PedidoVendaDao.GetPedidoVendaByID(aID);
end;

end.
