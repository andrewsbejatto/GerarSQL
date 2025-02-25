program GerarSQL;

uses
  Forms,
  Frm_Connection in 'src\Frm_Connection.pas' {FrmConnection},
  Frm_Principal in 'src\Frm_Principal.pas' {FrmPrincipal},
  Frm_Fundo in 'src\Frm_Fundo.pas' {FormFundo},
  Log in 'src\Log.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;

end.
