unit PedidoVendaItemController;

interface

uses
  Data.DB,
  FireDAC.Comp.Client,
  uPedidoVendaItemDao,
  PedidoVendaItemModel, FireDAC.Stan.Option;

type
  TPedidoVendaItemController = class
  private
	DBConexao         : TFDConnection;
	PedidoVendaItemDao: TPedidoVendaItemDAO;

	procedure StartTransaction;
	procedure Commit;
	procedure Rollback;
  public
	constructor Create(aConnection: TFDConnection);
	destructor Destroy; override;

	procedure CarregarTabela(aQuery: TFDQuery);
	procedure CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);

	function GetPedidoVendaItemByID(nCodigo: Integer; nPedido: Integer): TPedidoVendaItemModel;
	function NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
	function AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
	function DeletarItemPedidoVenda(nCodigo: Integer): Boolean;
  end;

implementation

{ TPedidoVendaItemController }

constructor TPedidoVendaItemController.Create(aConnection: TFDConnection);
begin
  DBConexao                      := aConnection;
  DBConexao.TxOptions.AutoCommit := False;
  DBConexao.TxOptions.Isolation  := xiReadCommitted;
  PedidoVendaItemDao             := TPedidoVendaItemDAO.Create(DBConexao);
end;

destructor TPedidoVendaItemController.Destroy;
begin
  PedidoVendaItemDao.Free;
  inherited;
end;

procedure TPedidoVendaItemController.StartTransaction;
begin
  if not DBConexao.InTransaction then
	DBConexao.StartTransaction;
end;

procedure TPedidoVendaItemController.Commit;
begin
  if DBConexao.InTransaction then
	DBConexao.Commit;
end;

procedure TPedidoVendaItemController.Rollback;
begin
  if DBConexao.InTransaction then
	DBConexao.Rollback;
end;

procedure TPedidoVendaItemController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaItemDao.CarregarTabela(aQuery);
end;

procedure TPedidoVendaItemController.CarregarItensPedidoVenda(nPedido: Integer; aQuery: TFDQuery);
begin
  PedidoVendaItemDao.CarregarItensPedidoVenda(nPedido, aQuery);
end;

function TPedidoVendaItemController.GetPedidoVendaItemByID(nCodigo: Integer; nPedido: Integer): TPedidoVendaItemModel;
begin
  Result := PedidoVendaItemDao.GetPedidoVendaItemByID(nCodigo, nPedido);
end;

function TPedidoVendaItemController.NovoItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
begin
  StartTransaction;
  try
	Result := PedidoVendaItemDao.NovoItemPedidoVenda(aPedidoVendaItemModel);
	Commit;
  except
	Rollback;
	raise;
  end;
end;

function TPedidoVendaItemController.AlterarItemPedidoVenda(aPedidoVendaItemModel: TPedidoVendaItemModel): Boolean;
begin
  StartTransaction;
  try
	Result := PedidoVendaItemDao.AlterarItemPedidoVenda(aPedidoVendaItemModel);
	Commit;
  except
	Rollback;
	raise;
  end;
end;

function TPedidoVendaItemController.DeletarItemPedidoVenda(nCodigo: Integer): Boolean;
begin
  StartTransaction;
  try
	Result := PedidoVendaItemDao.DeletarItemPedidoVenda(nCodigo);
	Commit;
  except
	Rollback;
	raise;
  end;
end;

end.
