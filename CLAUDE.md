# GerarSQL

Aplicativo VCL (Delphi, Win32) que monta comandos SELECT para bancos Firebird a partir de tabelas,
campos, filtros e ordenação escolhidos na tela. Os JOINs são deduzidos das chaves estrangeiras
(metadados `RDB$`). Código, comentários e mensagens em português.

## Estrutura

- `GerarSQL.dpr` / `GerarSQL.dproj` – projeto (unit nova precisa entrar nos dois).
- `src/Frm_Principal.pas` – tela principal e toda a geração do SQL:
  - `Gera_Script` – SELECT, WHERE, GROUP BY, HAVING, ORDER BY e limite de registros.
  - `Gera_Joins` – FROM/JOINs a partir das chaves estrangeiras entre as tabelas selecionadas.
- `src/FirebirdVersao.pas` – `TFirebirdVersao`: detecta a versão do Firebird que criou o banco
  (pela ODS) e decide a sintaxe compatível.
- `src/Frm_Connection.pas` – cadastro de conexões (salvas em `Connection.xml` ao lado do exe).
- `src/Frm_Fundo.pas` – fundo escurecido exibido durante diálogos modais.
- `src/Log.pas` – log via CodeSite (`TLog.Send` / `TLog.Error`); grava em `Log\` ao lado do exe.

## Regras importantes

- **Versão do banco**: `TFirebirdVersao.Detectar` lê a ODS pela API nativa
  (`TIBDatabase(Conexao.ConnectionIntf.CliObj).ods_version`) e, se falhar, por `MON$DATABASE`.
  ODS 10.0=FB1.0, 10.1=1.5, 11.0=2.0, 11.1=2.1, 11.2=2.5, 12=3.0, 13.0=4.0, 13.1=5.0.
  Sintaxe por versão: FB1.x `SELECT FIRST n`; FB2.x `ROWS n`; FB3+ `FETCH FIRST n ROWS ONLY`.
  Sem relacionamento: `CROSS JOIN` (FB2+) ou `INNER JOIN ... ON 1 = 1` (FB1.x).
  Versão não detectada mantém o comportamento antigo (`FIRST n`).
- **Consultas de metadados devem rodar no Firebird 1.x**: não usar `TRIM`, `COALESCE`,
  `ROWS` etc. no SQL; tratar no Delphi (`Trim`, checar os dois campos).
- **`RDB$SYSTEM_FLAG`** pode ser `NULL` em bancos antigos: usar
  `(RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL)`.
- **NOT NULL** pode estar no campo (`RDB$RELATION_FIELDS.RDB$NULL_FLAG`) ou no domínio
  (`RDB$FIELDS.RDB$NULL_FLAG`); considerar os dois. Campo da FK que aceita nulo gera LEFT JOIN.
- **Tabela repetida / apelidos**: itens de `LstTabelas_Selecionadas` são `TABELA` ou
  `TABELA APELIDO` (ex.: `PESSOA PESSOA_2`), que já é a sintaxe do FROM/JOIN.
  Use `Nome_Tabela(item)` para consultar metadados e `Apelido_Tabela(item)` como prefixo dos
  campos (`PESSOA_2.NOME`). Cada ocorrência usa uma chave estrangeira diferente (ordem
  alfabética da constraint); o par `constraint|apelido do detalhe` só é usado uma vez.
  Auto-relacionamento só é ligado quando a tabela aparece duas vezes.
- O texto dos filtros na lista é `TABELA.CAMPO "Condição" [valor]` e é interpretado por
  posição de `"`, `[` e `]` em `Gera_Script` – não colocar aspas duplas em nomes de campos.
- Não usar `OnFilterRecord`/`Filtered` em queries: filtrar em código (a perda de
  `Filtered = True` na migração IBX→FireDAC foi a causa dos JOINs errados).
- Projeto não depende mais de IBX (não vem instalado no Delphi novo); acesso só via FireDAC.

## Estilo

- Arquivos `.pas` em UTF-8 com BOM e CRLF; `.dfm` em texto com acentos como `#231` etc.
- Nomes em português; o código antigo usa `Nome_Com_Underline`, o mais novo usa prefixos
  `A` (parâmetros) e `L` (locais) – siga o padrão do trecho que estiver alterando.
- Strings multilinha `'''` e variáveis inline (`var x :=`) são usadas: exige Delphi 12+.

## Compilar (linha de comando)

Delphi instalado em `C:\Program Files (x86)\Embarcadero\Studio\37.0`; CodeSite em
`C:\Program Files (x86)\Raize\CS5\Lib\RX13\Win32`. Pelo PowerShell (o Git Bash estraga os caminhos):

```powershell
& "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\dcc32.exe" -B -Q `
  "-NSVcl;Vcl.Imaging;System;Xml;Data;Datasnap;Web;Soap;Winapi;System.Win;Data.Win;Bde" `
  "-UC:\Program Files (x86)\Raize\CS5\Lib\RX13\Win32" "-E<pasta_saida>" "-NU<pasta_saida>" -DDEBUG GerarSQL.dpr
```

Os hints H2443 de `MessageDlg` são antigos e podem ser ignorados.

## Testar

Há um Firebird 5 local (`C:\Program Files\Firebird\Firebird_5_0`, serviço
`FirebirdServerDefaultInstance`, SYSDBA/masterkey). Para validar a geração sem abrir a tela:
criar um banco de teste com `isql.exe`, e um programa console que cria `TFrmPrincipal`,
conecta `Cxo`, preenche `LstTabelas_Selecionadas`/`LstCampos_Selecionados`, chama
`Gera_Script` e executa `MemScript.Text` no `Query_Relatorio`. Liberar o form
(`FrmPrincipal.Free`) no fim, senão dá Runtime error 216 na finalização (só no teste).
Gerar arquivos de teste fora do repositório.
