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
  FListagemCliente in '..\source\view\Cliente\FListagemCliente.pas' {FrmListagemCliente},
  uConectarBaseController in '..\source\controller\classesGlobal\uConectarBaseController.pas',
  uConstantesController in '..\source\controller\classesGlobal\uConstantesController.pas',
  FListagenPedidoVenda in '..\source\view\PedidoVenda\FListagenPedidoVenda.pas' {FrmListagemPedidoVenda},
  FListagemProdutos in '..\source\view\Produto\FListagemProdutos.pas' {FrmListagemProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.Run;
end.
