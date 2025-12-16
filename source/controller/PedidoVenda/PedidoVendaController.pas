unit PedidoVendaController;

interface

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, uPedidoVendaDao, PedidoVendaModel,
  FireDAC.Stan.Option;

type
  TPedidoVendaController = class
  private
	PedidoVendaDao: TPedidoVendaDAO;
	DBConexao     : TFDConnection;

	procedure StartTransaction;
	procedure Commit;
	procedure Rollback;

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
  Result := False;
  StartTransaction;
  try
	Result := PedidoVendaDao.AlterarPedidoVenda(aPedidoVendaModel);
	Commit;
  except
	Rollback;
	raise;
  end;
end;

procedure TPedidoVendaController.CarregarTabela(aQuery: TFDQuery);
begin
  PedidoVendaDao.CarregarTabela(aQuery);
end;

procedure TPedidoVendaController.Commit;
begin
  if DBConexao.InTransaction then
	DBConexao.Commit;
end;

constructor TPedidoVendaController.Create(aConnection: TFDConnection);
begin
  DBConexao                      := aConnection;
  DBConexao.TxOptions.AutoCommit := False;
  DBConexao.TxOptions.Isolation  := xiReadCommitted;

  PedidoVendaDao := TPedidoVendaDAO.Create(DBConexao);
end;

function TPedidoVendaController.DeletarPedidoVenda(nCodigo: Integer): Boolean;
begin
  Result := False;
  StartTransaction;
  try
	Result := PedidoVendaDao.DeletarPedidoVenda(nCodigo);
	Commit;
  except
	Rollback;
	raise;
  end;
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

function TPedidoVendaController.GravarPedidoVenda(aPedidoVendaModel: TPedidoVendaModel): Boolean;
begin
  Result := False;
  StartTransaction;
  try
	Result := PedidoVendaDao.GravarPedidoVenda(aPedidoVendaModel);
	Commit;
  except
	Rollback;
	raise;
  end;
end;

function TPedidoVendaController.ObterDadosPedidoVenda(aID: Integer): TPedidoVendaModel;
begin
  Result := PedidoVendaDao.GetPedidoVendaByID(aID);
end;

procedure TPedidoVendaController.Rollback;
begin
  if DBConexao.InTransaction then
	DBConexao.Rollback;
end;

procedure TPedidoVendaController.StartTransaction;
begin
  if not DBConexao.InTransaction then
	DBConexao.StartTransaction;
end;

end.
