unit FirebirdVersao;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client;

type
  /// <summary>
  /// Versão do Firebird em que o banco foi criado, obtida pela ODS (On-Disk Structure)
  /// do arquivo, e os recursos de SQL disponíveis para essa versão.
  /// </summary>
  TFirebirdVersao = record
  public
    ODSMajor: Integer;
    ODSMinor: Integer;
    VersaoServidor: String;

    /// <summary>Versão do Firebird que criou o banco: 10, 15, 20, 21, 25, 30, 40, 50... (0 = desconhecida)</summary>
    function Versao: Integer;
    function Detectada: Boolean;
    function Descricao: String;

    function SuportaRows: Boolean;
    function SuportaFetchFirst: Boolean;
    function SuportaCrossJoin: Boolean;

    /// <summary>Cláusula de limite logo após o SELECT (ex.: FIRST 10)</summary>
    function LimiteInicio(const AQuantidade: String): String;
    /// <summary>Cláusula de limite no final do comando (ex.: ROWS 10 / FETCH FIRST 10 ROWS ONLY)</summary>
    function LimiteFim(const AQuantidade: String): String;
    /// <summary>Junção de uma tabela sem relacionamento (FK) com as demais</summary>
    function JoinSemRelacao(const ATabela: String): String;

    class function Detectar(AConexao: TFDConnection): TFirebirdVersao; static;
  end;

implementation

uses
  FireDAC.Phys.IBWrapper,
  Log;

{ TFirebirdVersao }

function TFirebirdVersao.Versao: Integer;
begin
  // ODS -> versão do Firebird que criou o banco
  case ODSMajor of
    0:  Result := 0;
    1..10:
      if ODSMinor >= 1 then
        Result := 15
      else
        Result := 10;
    11:
      case ODSMinor of
        0: Result := 20;
        1: Result := 21;
      else
        Result := 25;
      end;
    12: Result := 30;
    13:
      if ODSMinor >= 1 then
        Result := 50
      else
        Result := 40;
  else
    // ODS 14 = Firebird 6...
    Result := (ODSMajor - 8) * 10;
  end;
end;

function TFirebirdVersao.Detectada: Boolean;
begin
  Result := Versao > 0;
end;

function TFirebirdVersao.Descricao: String;
begin
  if not Detectada then
    Exit('Versão do Firebird não identificada');

  Result := Format('Banco criado no Firebird %d.%d (ODS %d.%d)',
    [Versao div 10, Versao mod 10, ODSMajor, ODSMinor]);

  if VersaoServidor <> '' then
    Result := Result + ' - Servidor: ' + VersaoServidor;
end;

function TFirebirdVersao.SuportaRows: Boolean;
begin
  Result := Versao >= 20;
end;

function TFirebirdVersao.SuportaFetchFirst: Boolean;
begin
  Result := Versao >= 30;
end;

function TFirebirdVersao.SuportaCrossJoin: Boolean;
begin
  Result := Versao >= 20;
end;

function TFirebirdVersao.LimiteInicio(const AQuantidade: String): String;
begin
  // Firebird 1.x só conhece FIRST; versão desconhecida mantém o comportamento antigo
  if (AQuantidade = '') or SuportaRows then
    Result := ''
  else
    Result := 'FIRST ' + AQuantidade;
end;

function TFirebirdVersao.LimiteFim(const AQuantidade: String): String;
begin
  if AQuantidade = '' then
    Result := ''
  else if SuportaFetchFirst then
    Result := 'FETCH FIRST ' + AQuantidade + ' ROWS ONLY'
  else if SuportaRows then
    Result := 'ROWS ' + AQuantidade
  else
    Result := '';
end;

function TFirebirdVersao.JoinSemRelacao(const ATabela: String): String;
begin
  if SuportaCrossJoin then
    Result := 'CROSS JOIN ' + ATabela
  else
    Result := 'INNER JOIN ' + ATabela + ' ON 1 = 1';
end;

class function TFirebirdVersao.Detectar(AConexao: TFDConnection): TFirebirdVersao;
begin
  Result := Default(TFirebirdVersao);

  if not AConexao.Connected or not SameText(AConexao.DriverName, 'FB') then
    Exit;

  // API nativa (isc_database_info): funciona em qualquer versão do Firebird
  try
    var LDatabase := TIBDatabase(AConexao.ConnectionIntf.CliObj);
    Result.ODSMajor := LDatabase.ods_version;
    Result.ODSMinor := LDatabase.ods_minor_version;

    var LVersoes := LDatabase.firebird_version;
    if LVersoes.Count >= 2 then
      Result.VersaoServidor := LVersoes[1]
    else if LVersoes.Count = 1 then
      Result.VersaoServidor := LVersoes[0];
  except
    on E: Exception do
      TLog.Error('Falha ao obter a ODS pela API: ' + E.Message);
  end;

  // Alternativa via tabela de monitoramento (Firebird 2.1 ou superior)
  if Result.ODSMajor = 0 then
  begin
    var LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := AConexao;
      LQuery.SQL.Text := 'SELECT MON$ODS_MAJOR, MON$ODS_MINOR FROM MON$DATABASE';
      try
        LQuery.Open;
        Result.ODSMajor := LQuery.Fields[0].AsInteger;
        Result.ODSMinor := LQuery.Fields[1].AsInteger;
      except
        on E: Exception do
          TLog.Error('Falha ao obter a ODS pelo MON$DATABASE: ' + E.Message);
      end;
    finally
      LQuery.Free;
    end;
  end;

  TLog.Send(Result.Descricao);
end;

end.
