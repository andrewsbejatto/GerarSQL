unit Log;

interface

uses
  CodeSiteLogging,
  System.IOUtils,
  System.SysUtils,
  System.StrUtils,
  System.DateUtils;

type
  TLog = class
  public
    class procedure Send(const AValue: String);
    class procedure Error(const AValue: String);
  end;

var
  CodeSiteDestino: TCodeSiteDestination;

implementation

procedure Inicializar;
begin
  CodeSiteDestino := TCodeSiteDestination.Create(nil);
  CodeSiteDestino.LogFile.FileName := FormatDateTime('ddmmyy_hhmmss', Now) + '.csl';
  var CaminhoLog := TPath.GetDirectoryName(ParamStr(0)) + '\Log';
  ForceDirectories(CaminhoLog);
  CodeSiteDestino.LogFile.FilePath := CaminhoLog;
  CodeSiteDestino.LogFile.Active := True;
  {$IFDEF RELEASE}
    CodeSiteDestino.Viewer.Active := False;
  {$ELSE}
    CodeSiteDestino.Viewer.Active := True;
  {$ENDIF}
  CodeSite.Destination := CodeSiteDestino;
  CodeSite.Send('Iniciando...');
end;

procedure Finalizar;
begin
  CodeSiteDestino.Free;
end;

{ TLog }

class procedure TLog.Error(const AValue: String);
begin
  CodeSite.SendError(AValue);
end;

class procedure TLog.Send(const AValue: String);
begin
  CodeSite.Send(AValue);
end;

initialization
  Inicializar;

finalization
  Finalizar;

end.
