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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nIDCliente : Integer;
  end;

var
  FrmListagemCliente   : TFrmListagemCliente;
  ClienteController    : TClienteController;


implementation

{$R *.dfm}

procedure TFrmListagemCliente.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  nIDCliente := QryCadastroBase.FieldByName('codigo').AsInteger;
end;

procedure TFrmListagemCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if ClienteController <> nil then
    ClienteController.Free;
end;

procedure TFrmListagemCliente.FormCreate(Sender: TObject);
begin
  inherited;
  nIDCliente := 0;
end;

procedure TFrmListagemCliente.FormShow(Sender: TObject);
begin
  inherited;
  ClienteController := TClienteController.Create;
  ClienteController.CarregarTabela(QryCadastroBase);
end;

end.
