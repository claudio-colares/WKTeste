unit FCarregarPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Comp.Client, uConstantesController, System.ImageList, Vcl.ImgList;

type
  TFrmCarregarPedidoVenda = class(TForm)
	pnlTitulo: TPanel;
	lblTitulo: TLabel;
	GroupBox1: TGroupBox;
	Panel1: TPanel;
	btnSelecionar: TBitBtn;
	btneditNumeroPedido: TButtonedEdit;
    imgListCarregaPedido: TImageList;
	procedure FormShow(Sender: TObject);
	procedure btnSelecionarClick(Sender: TObject);
	procedure btneditNumeroPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btneditNumeroPedidoRightButtonClick(Sender: TObject);
  private
	{ Private declarations }
	DBConexao        : TFDConnection;
	TipoPerssistencia: TTipoPersistencia;
  public
	{ Public declarations }
	constructor Create(AOwner: TComponent; AConnection: TFDConnection; aTipo: TTipoPersistencia); reintroduce;
    procedure ObterNumeroPedido(nPedido: Integer);
  end;

var
  FrmCarregarPedidoVenda: TFrmCarregarPedidoVenda;

implementation

{$R *.dfm}

uses FPedidoVenda, FListagenPedidoVenda;
{ TFrmCarregarPedidoVenda }

procedure TFrmCarregarPedidoVenda.btneditNumeroPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
	btnSelecionar.Click;
end;

procedure TFrmCarregarPedidoVenda.btneditNumeroPedidoRightButtonClick(Sender: TObject);
begin
  // ---------------------------------------------------------------------------
  // EXIBIR LISTAGEM DO CADASTRO DE PEDIDO
  // ---------------------------------------------------------------------------
  try
    FrmListagemPedidoVenda := TFrmListagemPedidoVenda.Create(Self, DBConexao);
	FrmListagemPedidoVenda.Position := poOwnerFormCenter;
	FrmListagemPedidoVenda.ShowModal;
  finally
	FrmListagemPedidoVenda.Free;
  end;
  // ---------------------------------------------------------------------------
end;

procedure TFrmCarregarPedidoVenda.btnSelecionarClick(Sender: TObject);
var
nPedido: Integer;
begin
  nPedido := StrToIntDef(btneditNumeroPedido.Text, 0);

  if nPedido = 0 then
	exit;

  case TipoPerssistencia of
	tpCancelar:
    begin
	  FrmPedidoVenda.ExcluirPedidoVenda(nPedido);
      Self.Close;
    end;

	tpCarregar:
	  begin
		if FrmPedidoVenda.ObterDadosPedidoVenda(nPedido) then
		  Self.Close
		else
		begin
		  btneditNumeroPedido.SetFocus;
		  exit;
		end;
	  end;
  end;

end;

constructor TFrmCarregarPedidoVenda.Create(AOwner: TComponent; AConnection: TFDConnection; aTipo: TTipoPersistencia);
begin
  inherited Create(AOwner);
  DBConexao         := AConnection;
  TipoPerssistencia := aTipo;
end;

procedure TFrmCarregarPedidoVenda.FormShow(Sender: TObject);
begin
  case TipoPerssistencia of
	tpCancelar:
	  lblTitulo.Caption := 'Cancelar Pedido Venda';
	tpCarregar:
	  lblTitulo.Caption := 'Carregar Pedido Venda';
  end;
end;

procedure TFrmCarregarPedidoVenda.ObterNumeroPedido(nPedido: Integer);
begin
 btneditNumeroPedido.Clear;
 btneditNumeroPedido.Text := nPedido.ToString;
end;

end.
