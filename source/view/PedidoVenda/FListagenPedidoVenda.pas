unit FListagenPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FBaseListagemCadastro, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, PedidoVendaController;

type
  TFrmListagemPedidoVenda = class(TFrmCadastroBase)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListagemPedidoVenda : TFrmListagemPedidoVenda;
  PedidoVendaController  : TPedidoVendaController;

implementation

{$R *.dfm}

procedure TFrmListagemPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
    if PedidoVendaController <> nil then
    PedidoVendaController.Free;
end;

procedure TFrmListagemPedidoVenda.FormShow(Sender: TObject);
begin
  inherited;
  PedidoVendaController := TPedidoVendaController.Create;
  PedidoVendaController.CarregarTabela(QryCadastroBase);
end;

end.
