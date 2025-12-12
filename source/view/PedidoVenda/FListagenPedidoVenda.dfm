inherited FrmListagemPedidoVenda: TFrmListagemPedidoVenda
  Caption = 'FrmListagemPedidoVenda'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Caption = 'LISTAGEM DE PEDIDOS'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 229
    end
  end
  inherited pnlBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited pnlPesquisaCadastro: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited grpboxPesquisaCadastro: TGroupBox
      inherited editPesquisa: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
