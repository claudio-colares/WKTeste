inherited FrmListagemProdutos: TFrmListagemProdutos
  Caption = 'Listagem de Produtos'
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
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
      inherited dbgrdCadastroBase: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Caption = 'Descricao'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'precoVenda'
            Title.Caption = 'Prc. Venda'
            Visible = True
          end>
      end
    end
  end
  inherited QryCadastroBase: TFDQuery
    SQL.Strings = (
      'SELECT * FROM PRODUTOS')
  end
end
