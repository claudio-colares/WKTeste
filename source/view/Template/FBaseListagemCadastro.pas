unit FBaseListagemCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList, FPredidoVenda;

type
  TFrmCadastroBase = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlBotoes: TPanel;
    btnSelecionar: TBitBtn;
    dbgrdCadastroBase: TDBGrid;
    pnlPesquisaCadastro: TPanel;
    grpboxPesquisaCadastro: TGroupBox;
    dsCadastroBase: TDataSource;
    QryCadastroBase: TFDQuery;
    editPesquisa: TEdit;
    BitBtn2: TBitBtn;
    imgListCadastroBase: TImageList;
    procedure btnSelecionarClick(Sender: TObject);
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

end.
