inherited FrmListagemProdutos: TFrmListagemProdutos
  Caption = 'Listagem de Produtos'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Width = 618
      Height = 34
      Caption = 'Listagem de Produtos'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 214
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
