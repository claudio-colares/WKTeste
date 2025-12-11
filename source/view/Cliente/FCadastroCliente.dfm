inherited FrmCadastroCliente: TFrmCadastroCliente
  Caption = 'FrmCadastroCliente'
  StyleElements = [seFont, seClient, seBorder]
  OnShow = FormShow
  TextHeight = 21
  inherited pnlTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblTitulo: TLabel
      Width = 618
      Height = 34
      Caption = 'CADASTRO DE CLIENTE'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 618
    end
  end
  inherited pnlBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
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
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
  end
end
