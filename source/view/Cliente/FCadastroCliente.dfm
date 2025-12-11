inherited FrmCadastroBase1: TFrmCadastroBase1
  Caption = 'FrmCadastroBase1'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Caption = 'CADASTRO DE CLIENTE'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 232
    end
  end
  inherited pnlBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited BitBtn1: TBitBtn
      OnClick = nil
    end
  end
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
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Caption = 'UF'
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
    Active = True
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
  end
end
