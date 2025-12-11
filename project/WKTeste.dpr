program WKTeste;

uses
  Vcl.Forms,
  FrmPredidoVenda in '..\source\view\PedidoVenda\FrmPredidoVenda.pas' {FrmPedidoVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.Run;
end.
