object FrmConecta: TFrmConecta
  Left = 403
  Top = 164
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Connect'
  ClientHeight = 178
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object Label8: TLabel
    Left = 8
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label9: TLabel
    Left = 8
    Top = 96
    Width = 53
    Height = 13
    Caption = 'User Name'
  end
  object Label10: TLabel
    Left = 144
    Top = 96
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Server'
  end
  object EdtCaminho: TEdit
    Left = 8
    Top = 72
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object EdtUser: TEdit
    Left = 8
    Top = 112
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'SYSDBA'
  end
  object EdtPassWord: TEdit
    Left = 144
    Top = 112
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'masterkey'
  end
  object Button4: TButton
    Left = 144
    Top = 144
    Width = 121
    Height = 25
    Caption = 'Connect'
    TabOrder = 3
    OnClick = Button4Click
  end
  object edtServer: TEdit
    Left = 7
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 4
    Text = '127.0.0.1'
  end
end
