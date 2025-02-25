object FrmPrincipal: TFrmPrincipal
  Left = 247
  Top = 130
  Caption = 'Gerar Consulta v0.0.0.1'
  ClientHeight = 802
  ClientWidth = 893
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 16
    Top = 352
    Width = 23
    Height = 22
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 506
    Width = 887
    Height = 296
    Margins.Top = 5
    Margins.Bottom = 0
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'SQL'
      object MemScript: TMemo
        Left = 0
        Top = 49
        Width = 879
        Height = 219
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 879
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Lista_Joins: TListBox
          Left = 185
          Top = 0
          Width = 694
          Height = 49
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          TabOrder = 0
          Visible = False
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 49
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object BtnGera_Sql: TSpeedButton
            Left = 8
            Top = 0
            Width = 80
            Height = 25
            Caption = 'Gerar SQL'
            OnClick = BtnGera_SqlClick
          end
          object BtnPrepara: TSpeedButton
            Left = 95
            Top = 0
            Width = 80
            Height = 25
            Caption = 'Preparar'
            OnClick = BtnPreparaClick
          end
          object SpeedButton2: TSpeedButton
            Left = 8
            Top = 25
            Width = 167
            Height = 24
            Caption = 'Copy to Clipboard'
            OnClick = SpeedButton2Click
          end
        end
        object MemPlan: TMemo
          Left = 185
          Top = 0
          Width = 694
          Height = 49
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta'
      ImageIndex = 1
      object GrdConsulta: TDBGrid
        Left = 0
        Top = 0
        Width = 896
        Height = 268
        Align = alClient
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Verdana'
        TitleFont.Style = []
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 155
    Width = 887
    Height = 346
    Margins.Top = 5
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      883
      342)
    object Label6: TLabel
      Left = 8
      Top = 200
      Width = 205
      Height = 13
      Caption = 'Campos para Filtragem / Ordena'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Tabelas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbCampos: TLabel
      Left = 8
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Campos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 376
      Top = 8
      Width = 126
      Height = 13
      Caption = 'Tabelas Selecionadas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LstCampos: TListBox
      Left = 8
      Top = 64
      Width = 313
      Height = 129
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
    object LstTabelas_Selecionadas: TListBox
      Left = 375
      Top = 24
      Width = 458
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnClick = LstTabelas_SelecionadasClick
    end
    object BtnAdd: TButton
      Left = 332
      Top = 80
      Width = 33
      Height = 25
      Hint = 'Adicionar campo'
      Caption = '>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnAddClick
    end
    object BtnAddAll: TButton
      Left = 332
      Top = 104
      Width = 33
      Height = 25
      Hint = 'Adicionar todos os campos'
      Caption = '>>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BtnAddAllClick
    end
    object BtnRem: TButton
      Left = 332
      Top = 128
      Width = 33
      Height = 25
      Hint = 'Remover Campo'
      Caption = '<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BtnRemClick
    end
    object BtnRemAll: TButton
      Left = 332
      Top = 152
      Width = 33
      Height = 25
      Hint = 'Remover todos os campos'
      Caption = '<<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BtnRemAllClick
    end
    object CmbTabelas: TComboBox
      Left = 8
      Top = 24
      Width = 313
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Sorted = True
      TabOrder = 6
    end
    object LstCampos_Filtro: TListBox
      Left = 8
      Top = 216
      Width = 313
      Height = 97
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 7
    end
    object Button1: TButton
      Left = 332
      Top = 224
      Width = 33
      Height = 25
      Hint = 'Adicionar condi'#231#227'o ou ordena'#231#227'o'
      Caption = '>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 332
      Top = 248
      Width = 33
      Height = 25
      Hint = 'Remover condi'#231#227'o ou ordena'#231#227'o'
      Caption = '<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 332
      Top = 272
      Width = 33
      Height = 25
      Hint = 'Adicionar Par'#226'metro'
      Caption = ':>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = Button3Click
    end
    object PCCondicao_Ordem: TPageControl
      Left = 375
      Top = 200
      Width = 497
      Height = 113
      ActivePage = TabSheet3
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 11
      OnChange = PCCondicao_OrdemChange
      object TabSheet3: TTabSheet
        Caption = 'Condi'#231#227'o para Campos'
        object LstFiltro: TListBox
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 489
          Height = 61
          Hint = 'D'#234' um clique duplo para alterar'
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = LstFiltroDblClick
        end
        object CmbCondicao: TComboBox
          Left = 0
          Top = 0
          Width = 489
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'Igual'
            'Diferente'
            'Maior ou Igual'
            'Menor ou Igual'
            'Come'#231'ando com'
            'Contendo'
            'N'#227'o Come'#231'ando com'
            'N'#227'o Contendo')
        end
      end
      object TabSheet7: TTabSheet
        Caption = 'Condi'#231#227'o para Campos Agregados'
        ImageIndex = 2
        object LstFiltro_Campos_Agregados: TListBox
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 489
          Height = 61
          Hint = 'D'#234' um clique duplo para alterar'
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = LstFiltro_Campos_AgregadosDblClick
        end
        object CmbCondicao_Agregados: TComboBox
          Left = 0
          Top = 0
          Width = 489
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'Igual'
            'Diferente'
            'Maior ou Igual'
            'Menor ou Igual')
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Ordem'
        ImageIndex = 1
        object CmbOrdem: TComboBox
          Left = 0
          Top = 0
          Width = 489
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'Crescente'
            'Decrescente')
        end
        object LstOrdem: TListBox
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 489
          Height = 61
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          TabOrder = 1
        end
      end
      object TabSheet8: TTabSheet
        Caption = 'Selecionar os Primeiros'
        ImageIndex = 3
        object EdtFirst: TEdit
          Left = 8
          Top = 8
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Text = '0'
        end
        object UDFirst: TUpDown
          Left = 129
          Top = 8
          Width = 15
          Height = 21
          Associate = EdtFirst
          Max = 1000
          TabOrder = 1
        end
        object ChkTodos: TCheckBox
          Left = 8
          Top = 32
          Width = 137
          Height = 17
          Caption = 'Selecionar todos'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = ChkTodosClick
        end
      end
    end
    object GBCampos_Selecionados: TPageControl
      Left = 375
      Top = 80
      Width = 501
      Height = 113
      ActivePage = TabSheet5
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 12
      object TabSheet5: TTabSheet
        Caption = 'Campos Selecionados'
        object LstCampos_Selecionados: TListBox
          Left = 0
          Top = 0
          Width = 493
          Height = 85
          Hint = 'D'#234' um clique duplo para alterar'
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
        end
      end
      object TabSheet6: TTabSheet
        Caption = 'Campos Agregados'
        ImageIndex = 1
        object LstCampos_Agregados: TListBox
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 493
          Height = 61
          Hint = 'D'#234' um clique duplo para alterar'
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = LstCampos_AgregadosDblClick
        end
        object CmbFuncao: TComboBox
          Left = 0
          Top = 0
          Width = 493
          Height = 21
          Align = alTop
          Style = csDropDownList
          Sorted = True
          TabOrder = 1
          Items.Strings = (
            'Contar'
            'M'#225'ximo'
            'M'#233'dia'
            'M'#237'nimo'
            'Soma')
        end
      end
    end
    object Button4: TButton
      Left = 332
      Top = 16
      Width = 33
      Height = 25
      Hint = 'Adicionar Tabela'
      Caption = '>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 332
      Top = 40
      Width = 33
      Height = 25
      Hint = 'Remover Tabela'
      Caption = '<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 839
      Top = 24
      Width = 33
      Height = 50
      Hint = 'Mudar Posi'#231#227'o da Tabela para Cima'
      Anchors = [akTop, akRight]
      Caption = '^'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      OnClick = Button6Click
    end
  end
  object pnCONN: TPanel
    Left = 0
    Top = 0
    Width = 893
    Height = 150
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 5
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Panel9: TPanel
      Left = 5
      Top = 5
      Width = 883
      Height = 19
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Conex'#245'es'
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
    end
    object pnCONN_NAV: TPanel
      Left = 5
      Top = 118
      Width = 883
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 0
        Width = 89
        Height = 27
        DataSource = DTS_CNN
        VisibleButtons = [nbInsert, nbDelete]
        Align = alLeft
        TabOrder = 0
      end
      object btnConectar: TBitBtn
        Left = 755
        Top = 0
        Width = 128
        Height = 27
        Align = alRight
        Caption = 'Conectar'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000010000FF00FF00393B
          3E000047000000490000004C00000052000001550100005B0100015F0100035B
          0500035C05000160010002660400016A010006660C00056A0800056E0C000373
          040003740600007F0000076F1100077011000E7A1A006F707300018802000C87
          1F000B8C1A001386220015A533001EB2350020C13A001AB641002CD34A0032DC
          6400004BC000004DC200004DC4000151C6000452CB000558D000075CD4000B64
          D700116ED7000D68E200116CE9001573E6001676E5001777E9001F81FF002489
          E9002083FE002184FF00268BFF00288FF8002D96FF003EABFF0042B2FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000242400000000000000000000242424252E3524000000000000
          000026262F38372E2400000000000000000024342A3136322400000000000000
          0000002437292C302400000000000000000000002432282B2400000000000000
          170100000024302824000000000F051701001717000024240000000005152105
          0017010000000000000000000A1F1B200501001701000000000000000A1F190F
          1805170100000000000000000A1C1A0C0A1305000000000000000000150F120D
          0C05050000000000000000161D0A0303030300000000000000000E1E12020000
          00000000000000000000050A0300000000000000000000000000}
        TabOrder = 1
        OnClick = btnConectarClick
      end
    end
    object Panel10: TPanel
      AlignWithMargins = True
      Left = 8
      Top = 58
      Width = 877
      Height = 57
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      Color = clWhite
      Enabled = False
      ParentBackground = False
      TabOrder = 2
      object DBText3: TDBText
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 865
        Height = 18
        Align = alTop
        DataField = 'CNN_Server'
        DataSource = DTS_CNN
        ExplicitLeft = 0
        ExplicitTop = 45
        ExplicitWidth = 340
      end
      object DBRichEdit1: TDBRichEdit
        AlignWithMargins = True
        Left = 6
        Top = 30
        Width = 865
        Height = 21
        Align = alClient
        BorderStyle = bsNone
        DataField = 'CNN_Database'
        DataSource = DTS_CNN
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        TabOrder = 0
      end
    end
    object Combo_Connection: TComboBox
      Left = 5
      Top = 24
      Width = 883
      Height = 31
      Align = alTop
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = Combo_ConnectionChange
    end
  end
  object IBTransaction_: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 88
    Top = 120
  end
  object Query_: TIBQuery
    Transaction = IBTransaction_
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = False
    SQL.Strings = (
      'SELECT * FROM VENDAS, ITENS_VENDAS')
    PrecommittedReads = False
    Left = 160
    Top = 120
  end
  object Query2_: TIBQuery
    Transaction = IBTransaction_
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 224
    Top = 120
  end
  object DS_Query_Relatorio: TDataSource
    DataSet = Query_Relatorio
    Left = 200
    Top = 232
  end
  object Query_Relatorio_: TIBQuery
    Transaction = IBTransaction_
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 88
    Top = 240
  end
  object IBSQL_: TIBSQL
    Transaction = IBTransaction_
    Left = 280
    Top = 96
  end
  object Query_Join_: TIBQuery
    Transaction = IBTransaction_
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Filtered = True
    PrecommittedReads = False
    OnFilterRecord = Query_Join_FilterRecord
    Left = 96
    Top = 64
  end
  object Cxo: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 392
    Top = 272
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 494
    Top = 204
  end
  object DTS_CNN: TDataSource
    AutoEdit = False
    DataSet = CDS_CNN
    Left = 632
    Top = 24
  end
  object CDS_CNN: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterInsert = CDS_CNNAfterInsert
    BeforePost = CDS_CNNBeforePost
    AfterPost = CDS_CNNAfterPost
    AfterDelete = CDS_CNNAfterDelete
    OnNewRecord = CDS_CNNNewRecord
    Left = 552
    Top = 16
    object CDS_CNNCNN_Type: TStringField
      FieldName = 'CNN_Type'
    end
    object CDS_CNNCNN_Name: TStringField
      FieldName = 'CNN_Name'
      Size = 30
    end
    object CDS_CNNCNN_Server: TStringField
      FieldName = 'CNN_Server'
      Size = 500
    end
    object CDS_CNNCNN_Port: TIntegerField
      FieldName = 'CNN_Port'
    end
    object CDS_CNNCNN_Database: TStringField
      FieldName = 'CNN_Database'
      Size = 500
    end
    object CDS_CNNCNN_Schema: TStringField
      FieldName = 'CNN_Schema'
      Size = 50
    end
    object CDS_CNNCNN_UserName: TStringField
      FieldName = 'CNN_UserName'
      Size = 50
    end
    object CDS_CNNCNN_Password: TStringField
      FieldName = 'CNN_Password'
      Size = 50
    end
  end
  object Query: TFDQuery
    Connection = Cxo
    Transaction = FDTransaction
    Left = 456
    Top = 272
  end
  object Query2: TFDQuery
    Connection = Cxo
    Transaction = FDTransaction
    Left = 524
    Top = 270
  end
  object Query_Join: TFDQuery
    Connection = Cxo
    Transaction = FDTransaction
    Left = 592
    Top = 272
  end
  object Query_Relatorio: TFDQuery
    Connection = Cxo
    Transaction = FDTransaction
    Left = 676
    Top = 278
  end
  object FDTransaction: TFDTransaction
    Options.ReadOnly = True
    Connection = Cxo
    Left = 764
    Top = 278
  end
end
