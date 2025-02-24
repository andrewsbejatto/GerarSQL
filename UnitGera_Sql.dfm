object FrmGera_Sql: TFrmGera_Sql
  Left = 247
  Top = 130
  Caption = 'Gerar Consulta'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    784
    561)
  TextHeight = 13
  object Label6: TLabel
    Left = 16
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
    Left = 16
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
    Left = 16
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
  object SpeedButton1: TSpeedButton
    Left = 16
    Top = 352
    Width = 23
    Height = 22
  end
  object LstCampos: TListBox
    Left = 16
    Top = 64
    Width = 313
    Height = 129
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 1
  end
  object LstTabelas_Selecionadas: TListBox
    Left = 376
    Top = 24
    Width = 369
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Columns = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 6
    OnClick = LstTabelas_SelecionadasClick
  end
  object BtnAdd: TButton
    Left = 336
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
    Left = 336
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
    Left = 336
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
    Left = 336
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
    Left = 16
    Top = 24
    Width = 313
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    Sorted = True
    TabOrder = 0
  end
  object LstCampos_Filtro: TListBox
    Left = 16
    Top = 216
    Width = 313
    Height = 97
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 7
  end
  object Button1: TButton
    Left = 336
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
    Left = 336
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
    Left = 336
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
  object PageControl1: TPageControl
    Left = 16
    Top = 320
    Width = 761
    Height = 241
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 12
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'SQL'
      object MemScript: TMemo
        Left = 0
        Top = 49
        Width = 753
        Height = 164
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 753
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Lista_Joins: TListBox
          Left = 145
          Top = 0
          Width = 608
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
          Width = 145
          Height = 49
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object BtnGera_Sql: TSpeedButton
            Left = 8
            Top = 0
            Width = 62
            Height = 25
            Caption = 'Gerar SQL'
            OnClick = BtnGera_SqlClick
          end
          object BtnPrepara: TSpeedButton
            Left = 71
            Top = 0
            Width = 62
            Height = 25
            Caption = 'Preparar'
            OnClick = BtnPreparaClick
          end
          object SpeedButton2: TSpeedButton
            Left = 8
            Top = 25
            Width = 62
            Height = 24
            Caption = 'Transf'
            OnClick = SpeedButton2Click
          end
        end
        object MemPlan: TMemo
          Left = 145
          Top = 0
          Width = 608
          Height = 49
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
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
        Width = 753
        Height = 213
        Align = alClient
        DataSource = DS_Query_Relatorio
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object PCCondicao_Ordem: TPageControl
    Left = 376
    Top = 200
    Width = 401
    Height = 113
    ActivePage = TabSheet3
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 11
    OnChange = PCCondicao_OrdemChange
    object TabSheet3: TTabSheet
      Caption = 'Condi'#231#227'o para Campos'
      DesignSize = (
        393
        85)
      object LstFiltro: TListBox
        Left = 8
        Top = 24
        Width = 377
        Height = 57
        Hint = 'D'#234' um clique duplo para alterar'
        Anchors = [akLeft, akTop, akRight]
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
        OnDblClick = LstFiltroDblClick
      end
      object CmbCondicao: TComboBox
        Left = 8
        Top = 0
        Width = 201
        Height = 21
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
      DesignSize = (
        393
        85)
      object LstFiltro_Campos_Agregados: TListBox
        Left = 8
        Top = 24
        Width = 377
        Height = 57
        Hint = 'D'#234' um clique duplo para alterar'
        Anchors = [akLeft, akTop, akRight]
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
        Left = 8
        Top = 0
        Width = 201
        Height = 21
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
      DesignSize = (
        393
        85)
      object CmbOrdem: TComboBox
        Left = 8
        Top = 0
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        Items.Strings = (
          'Crescente'
          'Decrescente')
      end
      object LstOrdem: TListBox
        Left = 8
        Top = 24
        Width = 377
        Height = 57
        Anchors = [akLeft, akTop, akRight]
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
    Left = 376
    Top = 80
    Width = 401
    Height = 113
    ActivePage = TabSheet5
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 13
    object TabSheet5: TTabSheet
      Caption = 'Campos Selecionados'
      DesignSize = (
        393
        85)
      object LstCampos_Selecionados: TListBox
        Left = 8
        Top = 4
        Width = 377
        Height = 77
        Hint = 'D'#234' um clique duplo para alterar'
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Campos Agregados'
      ImageIndex = 1
      DesignSize = (
        393
        85)
      object LstCampos_Agregados: TListBox
        Left = 8
        Top = 24
        Width = 377
        Height = 57
        Hint = 'D'#234' um clique duplo para alterar'
        Anchors = [akLeft, akTop, akRight]
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
        OnDblClick = LstCampos_AgregadosDblClick
      end
      object CmbFuncao: TComboBox
        Left = 8
        Top = 0
        Width = 201
        Height = 21
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
    Left = 336
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
    TabOrder = 14
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 336
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
    TabOrder = 15
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 744
    Top = 24
    Width = 33
    Height = 49
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
    TabOrder = 16
    OnClick = Button6Click
  end
  object IBDatabase: TIBDatabase
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 16
    Top = 88
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 88
    Top = 120
  end
  object Query: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = False
    SQL.Strings = (
      'SELECT * FROM VENDAS, ITENS_VENDAS')
    PrecommittedReads = False
    Left = 160
    Top = 120
  end
  object Query2: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 224
    Top = 120
  end
  object DS_Query_Relatorio: TDataSource
    DataSet = Query_Relatorio
    Left = 248
    Top = 240
  end
  object Query_Relatorio: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 152
    Top = 240
  end
  object IBSQL: TIBSQL
    Database = IBDatabase
    Transaction = IBTransaction
    Left = 280
    Top = 96
  end
  object Query_Join: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Filtered = True
    PrecommittedReads = False
    OnFilterRecord = Query_JoinFilterRecord
    Left = 112
    Top = 72
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 360
    Top = 344
  end
  object Cxo: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginDialog = FDGUIxLoginDialog1
    Left = 384
    Top = 288
  end
end
