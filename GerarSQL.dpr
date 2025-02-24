program GerarSQL;

uses
  Forms,
  UnitGera_Sql in 'UnitGera_Sql.pas' {FrmGera_Sql},
  UnitConecta in 'UnitConecta.pas' {FrmConecta};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmGera_Sql, FrmGera_Sql);
  Application.CreateForm(TFrmConecta, FrmConecta);
  Application.Run;
end.
