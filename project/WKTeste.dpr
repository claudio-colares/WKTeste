program WKTeste;

uses
  Vcl.Forms,
  FPredidoVenda in '..\source\view\PedidoVenda\FPredidoVenda.pas' {FrmPedidoVenda},
  FPedidoVendaItem in '..\source\view\PedidoVenda\FPedidoVendaItem.pas' {FrmPedidoVendaItem},
  FuncoesController in '..\source\controller\classesGlobal\FuncoesController.pas',
  PedidoVendaController in '..\source\controller\PedidoVenda\PedidoVendaController.pas',
  PedidoVendaItemController in '..\source\controller\PedidoVenda\PedidoVendaItemController.pas',
  ProdutosController in '..\source\controller\Produtos\ProdutosController.pas',
  ClienteController in '..\source\controller\Cliente\ClienteController.pas',
  ProdutosModel in '..\source\model\Produtos\ProdutosModel.pas',
  ClienteModel in '..\source\model\Cliente\ClienteModel.pas',
  PedidoVendaItemModel in '..\source\model\PedidoVenda\PedidoVendaItemModel.pas',
  PedidoVendaModel in '..\source\model\PedidoVenda\PedidoVendaModel.pas',
  FBaseListagemCadastro in '..\source\view\Template\FBaseListagemCadastro.pas' {FrmCadastroBase},
  FCadastroCliente in '..\source\view\Cliente\FCadastroCliente.pas' {FrmCadastroBase1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.CreateForm(TFrmCadastroBase, FrmCadastroBase);
  Application.CreateForm(TFrmCadastroBase1, FrmCadastroBase1);
  Application.Run;
end.
