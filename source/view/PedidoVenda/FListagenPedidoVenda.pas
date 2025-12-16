unit FListagenPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FBaseListagemCadastro, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, PedidoVendaController, FCarregarPedidoVenda;

type
  TFrmListagemPedidoVenda = class(TFrmCadastroBase)
	procedure FormShow(Sender: TObject);
	procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelecionarClick(Sender: TObject);
  private
	{ Private declarations }
	DBConexao            : TFDConnection;
	PedidoVendaController: TPedidoVendaController;

  public
	{ Public declarations }
	constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
  end;

var
  FrmListagemPedidoVenda: TFrmListagemPedidoVenda;

implementation

{$R *.dfm}

procedure TFrmListagemPedidoVenda.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  FrmCarregarPedidoVenda.ObterNumeroPedido(QryCadastroBase.FieldByName('numero_pedido').AsInteger);
end;

constructor TFrmListagemPedidoVenda.Create(AOwner: TComponent; AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  DBConexao         := AConnection;
  PedidoVendaController := TPedidoVendaController.Create(DBConexao);
end;

procedure TFrmListagemPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(PedidoVendaController);
end;

procedure TFrmListagemPedidoVenda.FormShow(Sender: TObject);
begin
  inherited;
   try
    PedidoVendaController := TPedidoVendaController.Create(DBConexao);
    PedidoVendaController.CarregarTabela(QryCadastroBase);
   except
   on E: Exception do
   ShowMessage('Erro ao carregar lista de pedidos: ' + E.Message);
   end;
end;

end.
