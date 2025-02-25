object FormFundo: TFormFundo
  Left = 0
  Top = 0
  Cursor = crHourGlass
  AlphaBlend = True
  AlphaBlendValue = 128
  Anchors = []
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FormFundo'
  ClientHeight = 591
  ClientWidth = 983
  Color = clBlack
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDefault
  StyleElements = []
  TextHeight = 13
  object pnl: TGridPanel
    Left = 0
    Top = 0
    Width = 983
    Height = 591
    Cursor = crHourGlass
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lbl
        Row = 1
      end
      item
        Column = 0
        Control = lblMensagem
        Row = 2
      end
      item
        Column = 0
        Control = ProgressBar
        Row = 3
      end>
    ParentColor = True
    RowCollection = <
      item
        Value = 48.098178606119870000
      end
      item
        SizeStyle = ssAbsolute
        Value = 70.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        Value = 51.901821393880130000
      end>
    ShowCaption = False
    TabOrder = 0
    StyleElements = []
    DesignSize = (
      983
      591)
    object lbl: TLabel
      Left = 0
      Top = 212
      Width = 983
      Height = 70
      Align = alClient
      Alignment = taCenter
      Caption = 'Aguarde processando solicita'#231#227'o...'
      Color = 7930168
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -53
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      StyleElements = []
      ExplicitTop = 218
      ExplicitWidth = 922
      ExplicitHeight = 64
    end
    object lblMensagem: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 292
      Width = 983
      Height = 40
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Alignment = taCenter
      BiDiMode = bdLeftToRight
      Caption = 'AMensagem'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      StyleElements = []
      ExplicitTop = 298
      ExplicitWidth = 113
      ExplicitHeight = 25
    end
    object ProgressBar: TProgressBar
      Left = 266
      Top = 334
      Width = 451
      Height = 25
      Anchors = []
      TabOrder = 0
      Visible = False
      StyleElements = []
      ExplicitTop = 340
    end
  end
end
