object FrmCarregarPedidoVenda: TFrmCarregarPedidoVenda
  Left = 0
  Top = 0
  Caption = 'FrmCarregarPedidoVenda'
  ClientHeight = 209
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 21
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 304
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 6
      Height = 30
      Align = alClient
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 20
    Top = 60
    Width = 264
    Height = 88
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 20
    Align = alClient
    Caption = 'Informe o Numero do Pedido'
    TabOrder = 1
    object btneditNumeroPedido: TButtonedEdit
      AlignWithMargins = True
      Left = 22
      Top = 38
      Width = 220
      Height = 33
      Margins.Left = 20
      Margins.Top = 15
      Margins.Right = 20
      Margins.Bottom = 15
      Align = alClient
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnKeyDown = btneditNumeroPedidoKeyDown
      ExplicitHeight = 38
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 168
    Width = 304
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnSelecionar: TBitBtn
      AlignWithMargins = True
      Left = 202
      Top = 3
      Width = 99
      Height = 35
      Align = alRight
      Caption = '&Selecionar'
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
  end
end
