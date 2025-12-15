inherited FrmListagemCliente: TFrmListagemCliente
  Caption = 'FrmListagemCliente'
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Width = 232
      Caption = 'CADASTRO DE CLIENTE'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 232
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
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 270
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Title.Caption = 'Cidade'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'uf'
            Title.Caption = 'UF'
            Width = 70
            Visible = True
          end>
      end
    end
  end
  inherited QryCadastroBase: TFDQuery
    SQL.Strings = (
      '')
  end
end
