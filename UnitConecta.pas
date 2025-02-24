unit UnitConecta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles;

type
  TFrmConecta = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdtCaminho: TEdit;
    EdtUser: TEdit;
    EdtPassWord: TEdit;
    Button4: TButton;
    Label1: TLabel;
    edtServer: TEdit;
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     procedure Grava_Ini( Arquivo, chave, campo, valor : string);
     Function Ler_Ini( Arquivo, chave, campo : string)  : String;
  public
    { Public declarations }
  end;

var
  FrmConecta: TFrmConecta;

implementation

uses UnitGera_Sql;

{$R *.dfm}

procedure TFrmConecta.Grava_Ini( Arquivo, chave, campo, valor : string);
var Ini : TIniFile;
begin
    Ini := TIniFile.Create( Arquivo );
    Ini.WriteString( chave, campo, valor );
    Ini.Free;
end;

Function TFrmConecta.Ler_Ini( Arquivo, chave, campo : string)  : String;
var Ini : TIniFile;
begin
    Ini := TIniFile.Create( Arquivo );
    result  := Ini.ReadString( chave, campo, '');
    Ini.Free;
end;

procedure TFrmConecta.Button4Click(Sender: TObject);
begin
     FrmGera_Sql.IBDatabase.Connected := False;
     FrmGera_Sql.IBDatabase.Params.Clear;
     FrmGera_Sql.IBDatabase.DatabaseName := edtServer.Text + ':' + EdtCaminho.Text;
     FrmGera_Sql.IBDatabase.Params.Add( 'USER_NAME=' + EdtUser.Text );
     FrmGera_Sql.IBDatabase.Params.Add( 'password=' + EdtPassWord.Text );
     FrmGera_Sql.IBDatabase.Connected := True;

     Grava_Ini( ExtractFilePath( Application.ExeName ) + 'GERARSQL.ini' , 'CONFIGURACOES', 'CAMINHO', EdtCaminho.Text );

     ModalResult := MrOk;
end;

procedure TFrmConecta.FormShow(Sender: TObject);
begin
     EdtCaminho.Text := Ler_Ini( ExtractFilePath( Application.ExeName ) + 'GERARSQL.ini' , 'CONFIGURACOES', 'CAMINHO' );
end;


end.
