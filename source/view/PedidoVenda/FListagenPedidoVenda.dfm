inherited FrmListagemPedidoVenda: TFrmListagemPedidoVenda
  Caption = 'FrmListagemPedidoVenda'
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Width = 618
      Height = 34
      Caption = 'LISTAGEM DE PEDIDOS'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 229
    end
  end
  inherited pnlBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited dbgrdCadastroBase: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'numero_pedido'
        Title.Caption = 'Pedido N'#186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data_emissao'
        Title.Caption = 'Data Emiss'#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_cliente'
        Title.Caption = 'Cliente'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Title.Caption = 'Valor Total'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlPesquisaCadastro: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited grpboxPesquisaCadastro: TGroupBox
      inherited editPesquisa: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited QryCadastroBase: TFDQuery
    SQL.Strings = (
      '')
  end
end
