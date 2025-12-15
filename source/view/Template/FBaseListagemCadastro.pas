unit FBaseListagemCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList, FPedidoVenda;

type
  TFrmCadastroBase = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlBotoes: TPanel;
    btnSelecionar: TBitBtn;
    pnlPesquisaCadastro: TPanel;
    grpboxPesquisaCadastro: TGroupBox;
    dsCadastroBase: TDataSource;
    QryCadastroBase: TFDQuery;
    imgListCadastroBase: TImageList;
    dbgrdCadastroBase: TDBGrid;
    procedure btnSelecionarClick(Sender: TObject);
    procedure dbgrdCadastroBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdCadastroBaseDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroBase: TFrmCadastroBase;

implementation

{$R *.dfm}

procedure TFrmCadastroBase.btnSelecionarClick(Sender: TObject);
begin
  Modalresult := mrOk;
end;

procedure TFrmCadastroBase.dbgrdCadastroBaseDblClick(Sender: TObject);
begin
  btnSelecionar.Click;
end;

procedure TFrmCadastroBase.dbgrdCadastroBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnSelecionar.Click;
end;

procedure TFrmCadastroBase.FormShow(Sender: TObject);
begin
 dbgrdCadastroBase.SetFocus;
end;

end.
