program WKTeste;

uses
  Vcl.Forms,
  FrmPredidoVenda in '..\source\view\PedidoVenda\FrmPredidoVenda.pas' {FrmPedidoVenda},
  FrmPedidoVendaItem in '..\source\view\PedidoVenda\FrmPedidoVendaItem.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
