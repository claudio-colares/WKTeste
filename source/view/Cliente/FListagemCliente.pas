unit FListagemCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FBaseListagemCadastro, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, ClienteController;

type
  TFrmListagemCliente = class(TFrmCadastroBase)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelecionarClick(Sender: TObject);

  private
    { Private declarations }
  var
    DBConexao        : TFDConnection;
    ClienteController: TClienteController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection); reintroduce;
  end;

var
  FrmListagemCliente: TFrmListagemCliente;

implementation

{$R *.dfm}

uses FPedidoVenda;

procedure TFrmListagemCliente.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  FrmPedidoVenda.ObterDadosCliente(QryCadastroBase.FieldByName('codigo').AsInteger);
end;

constructor TFrmListagemCliente.Create(AOwner: TComponent; AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  DBConexao         := AConnection;
  ClienteController := TClienteController.Create(DBConexao);
end;

procedure TFrmListagemCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(ClienteController);
end;

procedure TFrmListagemCliente.FormShow(Sender: TObject);
begin
  inherited;
  try
    ClienteController.CarregarTabela(QryCadastroBase);
  except
    on E: Exception do
      ShowMessage('Erro ao carregar lista de clientes: ' + E.Message);
  end;
end;

end.
