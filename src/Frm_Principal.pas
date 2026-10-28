unit Frm_Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ComCtrls, Grids, DBGrids,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Login, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  Vcl.DBCtrls, FireDAC.Phys.IBBase, Datasnap.DBClient, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.AppEvnts,

  Frm_Fundo, FirebirdVersao;

type
  TFrmPrincipal = class(TForm)
    PageControlSQL: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MemScript: TMemo;
    GrdConsulta: TDBGrid;
    Panel2: TPanel;
    Lista_Joins: TListBox;
    Panel3: TPanel;
    BtnGera_Sql: TSpeedButton;
    BtnPrepara: TSpeedButton;
    MemPlan: TMemo;
    SpeedButton2: TSpeedButton;
    pnlTables: TPanel;
    Label6: TLabel;
    Label1: TLabel;
    LbCampos: TLabel;
    Label5: TLabel;
    LstCampos: TListBox;
    LstTabelas_Selecionadas: TListBox;
    BtnAdd: TButton;
    BtnAddAll: TButton;
    BtnRem: TButton;
    BtnRemAll: TButton;
    CmbTabelas: TComboBox;
    LstCampos_Filtro: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PCCondicao_Ordem: TPageControl;
    TabSheet3: TTabSheet;
    LstFiltro: TListBox;
    CmbCondicao: TComboBox;
    TabSheet7: TTabSheet;
    LstFiltro_Campos_Agregados: TListBox;
    CmbCondicao_Agregados: TComboBox;
    TabSheet4: TTabSheet;
    CmbOrdem: TComboBox;
    LstOrdem: TListBox;
    TabSheet8: TTabSheet;
    EdtFirst: TEdit;
    UDFirst: TUpDown;
    ChkTodos: TCheckBox;
    GBCampos_Selecionados: TPageControl;
    TabSheet5: TTabSheet;
    LstCampos_Selecionados: TListBox;
    TabSheet6: TTabSheet;
    LstCampos_Agregados: TListBox;
    CmbFuncao: TComboBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DS_Query_Relatorio: TDataSource;
    Cxo: TFDConnection;
    pnCONN: TPanel;
    Panel9: TPanel;
    pnCONN_NAV: TPanel;
    DBNavigator1: TDBNavigator;
    btnConectar: TBitBtn;
    Panel10: TPanel;
    DBText3: TDBText;
    DBRichEdit1: TDBRichEdit;
    Combo_Connection: TComboBox;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DTS_CNN: TDataSource;
    CDS_CNN: TClientDataSet;
    CDS_CNNCNN_Type: TStringField;
    CDS_CNNCNN_Name: TStringField;
    CDS_CNNCNN_Server: TStringField;
    CDS_CNNCNN_Port: TIntegerField;
    CDS_CNNCNN_Database: TStringField;
    CDS_CNNCNN_Schema: TStringField;
    CDS_CNNCNN_UserName: TStringField;
    CDS_CNNCNN_Password: TStringField;
    Query: TFDQuery;
    Query2: TFDQuery;
    Query_Join: TFDQuery;
    Query_Relatorio: TFDQuery;
    FDTransaction: TFDTransaction;
    ApplicationEvents1: TApplicationEvents;
    procedure FormShow(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnAddAllClick(Sender: TObject);
    procedure BtnRemClick(Sender: TObject);
    procedure BtnRemAllClick(Sender: TObject);
    function Verifica_View: Boolean;
    function eh_view: Boolean;
    procedure Gera_Script;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PageControlSQLChange(Sender: TObject);
    procedure LstCampos_AgregadosDblClick(Sender: TObject);
    procedure PCCondicao_OrdemChange(Sender: TObject);
    procedure LstFiltroDblClick(Sender: TObject);
    procedure LstFiltro_Campos_AgregadosDblClick(Sender: TObject);
    procedure ChkTodosClick(Sender: TObject);
    procedure LstTabelas_SelecionadasClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BtnGera_SqlClick(Sender: TObject);
    procedure BtnPreparaClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Combo_ConnectionChange(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure CDS_CNNAfterDelete(DataSet: TDataSet);
    procedure CDS_CNNAfterInsert(DataSet: TDataSet);
    procedure CDS_CNNAfterPost(DataSet: TDataSet);
    procedure CDS_CNNBeforePost(DataSet: TDataSet);
    procedure CDS_CNNNewRecord(DataSet: TDataSet);
    procedure ApplicationEvents1ModalBegin(Sender: TObject);
    procedure ApplicationEvents1ModalEnd(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CxoAfterConnect(Sender: TObject);
  private
    { Private declarations }
    FAppPathName: String;
    FVersao: TFirebirdVersao;
    procedure Gera_Joins;
    function E_View(const ATabela: String): Boolean;
    function Tabela_Selecionada(const ATabela: String): Boolean;
    function Novo_Apelido(const ATabela: String): String;
    procedure Conectar(Driver: String; Conn: TFDConnection;
      Server, Database, User, Pass: String; Port: Integer = 0);
  public
    { Public declarations }
    procedure SaveConnection;
    procedure LoadConnection;
  end;

var
  FrmPrincipal: TFrmPrincipal;
  Fundo: TFormFundo;

implementation

uses
  CodeSiteLogging,
  System.Generics.Collections,
  Vcl.Clipbrd,
  Frm_Connection,
  Log;

{$R *.dfm}

// Os itens de LstTabelas_Selecionadas são "TABELA" ou, quando a mesma tabela
// é adicionada mais de uma vez, "TABELA APELIDO" (que já é a sintaxe do FROM/JOIN)
function Nome_Tabela(const AItem: String): String;
begin
  if Pos(' ', AItem) > 0 then
    Result := Copy(AItem, 1, Pos(' ', AItem) - 1)
  else
    Result := AItem;
end;

// Nome usado para referenciar a tabela nos campos (TABELA.CAMPO ou APELIDO.CAMPO)
function Apelido_Tabela(const AItem: String): String;
begin
  if Pos(' ', AItem) > 0 then
    Result := Copy(AItem, Pos(' ', AItem) + 1, Length(AItem))
  else
    Result := AItem;
end;

type
  // Chave estrangeira entre duas tabelas selecionadas
  TRelacao = record
    Constraint: String;
    Mestre: String;
    Detalhe: String;
    Campos_Mestre: TArray<String>;
    Campos_Detalhe: TArray<String>;
    Nulo: Boolean;
  end;

procedure TFrmPrincipal.Gera_Joins;
const
  // Campos de cada chave estrangeira, com a tabela/campo referenciados e se aceitam nulo
  // (NOT NULL pode estar no campo ou no domínio). Sem TRIM/COALESCE para funcionar no Firebird 1.x
  SQL_RELACOES = '''
    SELECT
      RC.RDB$CONSTRAINT_NAME NOME_CONSTRAINT,
      RC.RDB$RELATION_NAME TABELA,
      ISEG.RDB$FIELD_NAME CAMPO,
      REF.RDB$RELATION_NAME TABELA_RELACIONADA,
      REFSEG.RDB$FIELD_NAME CAMPO_RELACIONADO,
      RF.RDB$NULL_FLAG NULO_CAMPO,
      F.RDB$NULL_FLAG NULO_DOMINIO,
      RFR.RDB$NULL_FLAG NULO_CAMPO_RELACIONADO,
      FR.RDB$NULL_FLAG NULO_DOMINIO_RELACIONADO
    FROM RDB$RELATION_CONSTRAINTS RC
      INNER JOIN RDB$INDICES IDX ON IDX.RDB$INDEX_NAME = RC.RDB$INDEX_NAME
      INNER JOIN RDB$INDEX_SEGMENTS ISEG ON ISEG.RDB$INDEX_NAME = IDX.RDB$INDEX_NAME
      INNER JOIN RDB$INDICES REF ON REF.RDB$INDEX_NAME = IDX.RDB$FOREIGN_KEY
      INNER JOIN RDB$INDEX_SEGMENTS REFSEG ON REFSEG.RDB$INDEX_NAME = REF.RDB$INDEX_NAME
        AND REFSEG.RDB$FIELD_POSITION = ISEG.RDB$FIELD_POSITION
      LEFT JOIN RDB$RELATION_FIELDS RF ON RF.RDB$RELATION_NAME = RC.RDB$RELATION_NAME
        AND RF.RDB$FIELD_NAME = ISEG.RDB$FIELD_NAME
      LEFT JOIN RDB$FIELDS F ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE
      LEFT JOIN RDB$RELATION_FIELDS RFR ON RFR.RDB$RELATION_NAME = REF.RDB$RELATION_NAME
        AND RFR.RDB$FIELD_NAME = REFSEG.RDB$FIELD_NAME
      LEFT JOIN RDB$FIELDS FR ON FR.RDB$FIELD_NAME = RFR.RDB$FIELD_SOURCE
    WHERE RC.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
    ORDER BY RC.RDB$CONSTRAINT_NAME, ISEG.RDB$FIELD_POSITION
    ''';
var
  i: Integer;
  Relacoes: TList<TRelacao>;
  Relacao: TRelacao;
  Nomes, Usadas, Pendentes, FKs_Usadas: TStringList;
  Constraint, Tabela, Tabela_Relacionada: String;
  Nulo: Boolean;
  Indice_Relacao, Indice_Pendente: Integer;
  Mestre, Detalhe: String;
  Paragrafo, Inner_Ou_Left, Linha: String;

  // Quantidade de chaves estrangeiras entre as duas tabelas
  function Quantidade_FKs(const AMestre, ADetalhe: String): Integer;
  begin
    Result := 0;
    for var r := 0 to Relacoes.Count - 1 do
      if (Relacoes[r].Mestre = AMestre) and (Relacoes[r].Detalhe = ADetalhe) then
        Inc(Result);
  end;

  function Monta_Condicao(const ARelacao: TRelacao; const AApelido_Mestre, AApelido_Detalhe: String): String;
  begin
    Result := '';
    for var c := 0 to High(ARelacao.Campos_Mestre) do
    begin
      if Result <> '' then
        Result := Result + ' AND ';
      Result := Result + AApelido_Mestre + '.' + ARelacao.Campos_Mestre[c] + ' = ' +
        AApelido_Detalhe + '.' + ARelacao.Campos_Detalhe[c];
    end;
  end;

  // Procura uma chave estrangeira ainda não usada entre a tabela pendente e alguma tabela
  // que já está no FROM/JOIN, dando preferência à última adicionada. Cada chave estrangeira
  // de uma ocorrência da tabela detalhe liga uma única vez: quando a tabela mestre é
  // repetida (com apelido), cada ocorrência usa a próxima chave estrangeira
  function Acha_Relacao(const APendente: String; out AMestre, ADetalhe: String): Integer;
  begin
    for var u := Usadas.Count - 1 downto 0 do
      for var r := 0 to Relacoes.Count - 1 do
        for var Pendente_E_Mestre := 0 to 1 do
        begin
          if Pendente_E_Mestre = 0 then
          begin
            AMestre := APendente;
            ADetalhe := Usadas[u];
          end
          else
          begin
            AMestre := Usadas[u];
            ADetalhe := APendente;
          end;

          if (Relacoes[r].Mestre = Nome_Tabela(AMestre)) and
             (Relacoes[r].Detalhe = Nome_Tabela(ADetalhe)) and
             (FKs_Usadas.IndexOf(Relacoes[r].Constraint + '|' + Apelido_Tabela(ADetalhe)) = -1) then
            Exit(r);
        end;
    Result := -1;
  end;

begin
  Relacoes := TList<TRelacao>.Create;
  Nomes := TStringList.Create;
  Usadas := TStringList.Create;
  Pendentes := TStringList.Create;
  FKs_Usadas := TStringList.Create;
  try
    for i := 0 to LstTabelas_Selecionadas.Count - 1 do
      Nomes.Add(Nome_Tabela(LstTabelas_Selecionadas.Items[i]));

    // Carregando as chaves estrangeiras entre as tabelas selecionadas
    Query_Join.SQL.Text := SQL_RELACOES;
    CodeSite.Send('Query_Join', Query_Join.SQL.Text);
    Query_Join.Open;
    try
      Constraint := '';
      while not Query_Join.Eof do
      begin
        Tabela := Trim(Query_Join.FieldByName('TABELA').AsString);
        Tabela_Relacionada := Trim(Query_Join.FieldByName('TABELA_RELACIONADA').AsString);

        // Só interessam ligações entre tabelas selecionadas. O auto-relacionamento
        // só é usado quando a tabela é adicionada mais de uma vez (com apelido)
        if (Nomes.IndexOf(Tabela) <> -1) and (Nomes.IndexOf(Tabela_Relacionada) <> -1) then
        begin
          // Se um dos campos da ligação admite nulo a ligação será LEFT JOIN
          Nulo :=
            ((Query_Join.FieldByName('NULO_CAMPO').AsInteger <> 1) and
             (Query_Join.FieldByName('NULO_DOMINIO').AsInteger <> 1)) or
            ((Query_Join.FieldByName('NULO_CAMPO_RELACIONADO').AsInteger <> 1) and
             (Query_Join.FieldByName('NULO_DOMINIO_RELACIONADO').AsInteger <> 1));

          if Trim(Query_Join.FieldByName('NOME_CONSTRAINT').AsString) <> Constraint then
          begin
            Constraint := Trim(Query_Join.FieldByName('NOME_CONSTRAINT').AsString);

            Relacao.Constraint := Constraint;
            Relacao.Mestre := Tabela_Relacionada;
            Relacao.Detalhe := Tabela;
            Relacao.Campos_Mestre := [Trim(Query_Join.FieldByName('CAMPO_RELACIONADO').AsString)];
            Relacao.Campos_Detalhe := [Trim(Query_Join.FieldByName('CAMPO').AsString)];
            Relacao.Nulo := Nulo;
            Relacoes.Add(Relacao);
          end
          else
          begin
            // Demais campos de uma chave composta
            Relacao := Relacoes.Last;
            Relacao.Campos_Mestre := Relacao.Campos_Mestre +
              [Trim(Query_Join.FieldByName('CAMPO_RELACIONADO').AsString)];
            Relacao.Campos_Detalhe := Relacao.Campos_Detalhe +
              [Trim(Query_Join.FieldByName('CAMPO').AsString)];
            Relacao.Nulo := Relacao.Nulo or Nulo;
            Relacoes[Relacoes.Count - 1] := Relacao;
          end;
        end;

        Query_Join.Next;
      end;
    finally
      Query_Join.Close;
    end;

    // A primeira tabela selecionada é sempre a do FROM
    Usadas.Add(LstTabelas_Selecionadas.Items[0]);
    MemScript.Lines.Add('FROM ' + LstTabelas_Selecionadas.Items[0]);

    for i := 1 to LstTabelas_Selecionadas.Count - 1 do
      Pendentes.Add(LstTabelas_Selecionadas.Items[i]);

    Paragrafo := '';

    // Cada tabela (ou ocorrência com apelido) entra uma única vez, ligada a uma tabela já adicionada
    while Pendentes.Count > 0 do
    begin
      Paragrafo := Paragrafo + '      ';

      Indice_Relacao := -1;
      Indice_Pendente := -1;
      for i := 0 to Pendentes.Count - 1 do
      begin
        Indice_Relacao := Acha_Relacao(Pendentes[i], Mestre, Detalhe);
        if Indice_Relacao <> -1 then
        begin
          Indice_Pendente := i;
          Break;
        end;
      end;

      if Indice_Pendente <> -1 then
      begin
        Relacao := Relacoes[Indice_Relacao];
        FKs_Usadas.Add(Relacao.Constraint + '|' + Apelido_Tabela(Detalhe));

        if Relacao.Nulo then
          Inner_Ou_Left := 'LEFT JOIN '
        else
          Inner_Ou_Left := 'INNER JOIN ';

        Linha := Paragrafo + Inner_Ou_Left + Pendentes[Indice_Pendente] + ' ON ' +
          Monta_Condicao(Relacao, Apelido_Tabela(Mestre), Apelido_Tabela(Detalhe));

        // Havendo mais de uma chave estrangeira entre as tabelas, indica qual foi usada
        if Quantidade_FKs(Relacao.Mestre, Relacao.Detalhe) > 1 then
          Linha := Linha + ' /* ' + Relacao.Constraint + ' */';

        MemScript.Lines.Add(Linha);
      end
      else
      begin
        // Nenhuma tabela restante tem chave estrangeira (ainda não usada) com as já adicionadas
        Indice_Pendente := 0;
        TLog.Error('Tabela sem relacionamento com as demais: ' + Pendentes[0]);
        MemScript.Lines.Add(Paragrafo + FVersao.JoinSemRelacao(Pendentes[0]) +
          ' /* sem chave estrangeira com as demais tabelas */');
      end;

      Usadas.Add(Pendentes[Indice_Pendente]);
      Pendentes.Delete(Indice_Pendente);
    end;
  finally
    FKs_Usadas.Free;
    Pendentes.Free;
    Usadas.Free;
    Nomes.Free;
    Relacoes.Free;
  end;
end;

procedure TFrmPrincipal.Gera_Script;
var
  i: Integer;
  Where: String;
  Operacao: String;
  Prefixo, Sulfixo: String;
  Quantidade: String;

  // Acha a posição do campo para o order by
  function Acha_Indice(Campo: String): String;
  begin
    if LstCampos_Selecionados.Items.IndexOf(Campo) <> -1 then
      Result := IntToStr(LstCampos_Selecionados.Items.IndexOf(Campo) + 1)
    else
      Result := IntToStr(LstCampos_Selecionados.Count +
        LstCampos_Agregados.Items.IndexOf(Campo) + 1);
  end;

begin
  MemScript.Clear;

  // Quantidade de registros (FIRST / ROWS / FETCH FIRST conforme a versão do banco)
  if not ChkTodos.Checked then
    Quantidade := Trim(EdtFirst.Text)
  else
    Quantidade := '';

  if (LstTabelas_Selecionadas.Count > 0) then
  begin
    MemScript.Lines.Add(TrimRight('SELECT ' + FVersao.LimiteInicio(Quantidade)));

    // Selecionando os campos a serem exibidos
    if LstCampos_Selecionados.Items.Count + LstCampos_Agregados.Items.Count > 0
    then
    begin
      For i := 0 to LstCampos_Selecionados.Items.Count - 1 do
      begin
        if i = LstCampos_Selecionados.Items.Count - 1 then
        begin
          if LstCampos_Agregados.Items.Count > 0 then
            MemScript.Lines.Add('      ' + LstCampos_Selecionados.Items
              [i] + ', ')
          else
            MemScript.Lines.Add('      ' + LstCampos_Selecionados.Items[i]);
        end
        else
          MemScript.Lines.Add('      ' + LstCampos_Selecionados.Items
            [i] + ', ');
      end;

      For i := 0 to LstCampos_Agregados.Items.Count - 1 do
      begin
        if i = LstCampos_Agregados.Items.Count - 1 then
          MemScript.Lines.Add('      ' + LstCampos_Agregados.Items[i])
        else
          MemScript.Lines.Add('      ' + LstCampos_Agregados.Items[i] + ', ');
      end;
    end
    else
      MemScript.Lines.Add('      *');

    // verificar se será selecionada apenas uma tabela ou será necessário fazer ligações
    if LstTabelas_Selecionadas.Items.Count = 1 then
      MemScript.Lines.Add('FROM ' + LstTabelas_Selecionadas.Items[0])
    else
      Gera_Joins;
  end;

  // Selecionando o filtro "WHERE"
  For i := 0 to LstFiltro.Items.Count - 1 do
  begin
    if Pos('Maior ou Igual', LstFiltro.Items[i]) > 0 then
    begin
      Operacao := ' >= ';

      Prefixo := '';
      Sulfixo := '';
    end
    else if Pos('Menor ou Igual', LstFiltro.Items[i]) > 0 then
    begin
      Operacao := ' <= ';

      Prefixo := '';
      Sulfixo := '';
    end
    else if Pos('Igual', LstFiltro.Items[i]) > 0 then
    begin
      Operacao := ' = ';

      Prefixo := '';
      Sulfixo := '';
    end
    else if Pos('Diferente', LstFiltro.Items[i]) > 0 then
    begin
      Operacao := ' <> ';

      Prefixo := '';
      Sulfixo := '';
    end
    else if (Pos('Não Começando com', LstFiltro.Items[i]) > 0) then
    begin
      Operacao := ' NOT LIKE ';

      Prefixo := '''';
      Sulfixo := '%''';
    end
    else if (Pos('Não Contendo', LstFiltro.Items[i]) > 0) then
    begin
      Operacao := ' NOT LIKE ';

      Prefixo := '''%';
      Sulfixo := '%''';
    end
    else if (Pos('Começando com', LstFiltro.Items[i]) > 0) then
    begin
      Operacao := ' LIKE ';

      Prefixo := '''';
      Sulfixo := '%''';
    end
    else if (Pos('Contendo', LstFiltro.Items[i]) > 0) then
    begin
      Operacao := ' LIKE ';

      Prefixo := '''%';
      Sulfixo := '%''';
    end;

    Where := Copy(LstFiltro.Items[i], 1, Pos('"', LstFiltro.Items[i]) - 2) +
      Operacao + Prefixo + Copy(LstFiltro.Items[i], Pos('[', LstFiltro.Items[i])
      + 1, Pos(']', LstFiltro.Items[i]) - 1 - Pos('[', LstFiltro.Items[i]))
      + Sulfixo;

    if i <> LstFiltro.Count - 1 then
      Where := Where + ' AND ';

    if i = 0 then
      MemScript.Lines.Add('WHERE ' + Where)
    else
      MemScript.Lines.Add('      ' + Where);
  end;

  // Selecionando o GROUP BY
  if LstCampos_Agregados.Items.Count > 0 then
  begin
    For i := 0 to LstCampos_Selecionados.Items.Count - 1 do
    begin
      if i = LstCampos_Selecionados.Items.Count - 1 then
      begin
        if i = 0 then
          MemScript.Lines.Add('GROUP BY ' + LstCampos_Selecionados.Items[i])
        else
          MemScript.Lines.Add('      ' + LstCampos_Selecionados.Items[i]);
      end
      else
      begin
        if i = 0 then
          MemScript.Lines.Add('GROUP BY ' + LstCampos_Selecionados.Items
            [i] + ', ')
        else
          MemScript.Lines.Add('      ' + LstCampos_Selecionados.Items
            [i] + ', ');
      end;
    end;
  end;

  // Selecionando o filtro "HAVING"
  For i := 0 to LstFiltro_Campos_Agregados.Items.Count - 1 do
  begin
    if Pos('Maior ou Igual', LstFiltro_Campos_Agregados.Items[i]) > 0 then
      Operacao := ' >= '
    else if Pos('Menor ou Igual', LstFiltro_Campos_Agregados.Items[i]) > 0 then
      Operacao := ' <= '
    else if Pos('Igual', LstFiltro_Campos_Agregados.Items[i]) > 0 then
      Operacao := ' = '
    else if Pos('Diferente', LstFiltro_Campos_Agregados.Items[i]) > 0 then
      Operacao := ' <> ';

    Where := Copy(LstFiltro_Campos_Agregados.Items[i], 1,
      Pos('"', LstFiltro_Campos_Agregados.Items[i]) - 2) + Operacao +
      Copy(LstFiltro_Campos_Agregados.Items[i],
      Pos('[', LstFiltro_Campos_Agregados.Items[i]) + 1,
      Pos(']', LstFiltro_Campos_Agregados.Items[i]) - 1 - Pos('[',
      LstFiltro_Campos_Agregados.Items[i]));

    if i = LstFiltro_Campos_Agregados.Items.Count - 1 then
    begin
      if i = 0 then
        MemScript.Lines.Add('HAVING ' + Where)
      else
        MemScript.Lines.Add('       ' + Where);
    end
    else
    begin
      if i = 0 then
        MemScript.Lines.Add('HAVING ' + Where + ' AND ')
      else
        MemScript.Lines.Add('       ' + Where + ' AND ');
    end;
  end;

  // Selecionando ORDER BY. Sempre pelo índice do campo
  For i := 0 to LstOrdem.Items.Count - 1 do
  begin
    // Se não for o último campo da lista devo adicionar um sulfixo com ','
    if i <> LstOrdem.Items.Count - 1 then
      Sulfixo := ', '
    else
      Sulfixo := '';

    if i = 0 then
    begin
      if Pos('[Crescente]', LstOrdem.Items[i]) > 0 then
        MemScript.Lines.Add('ORDER BY ' + Acha_Indice(Copy(LstOrdem.Items[i], 1,
          Pos('[Crescente]', LstOrdem.Items[i]) - 2)) + Sulfixo)
      else
        MemScript.Lines.Add('ORDER BY ' + Acha_Indice(Copy(LstOrdem.Items[i], 1,
          Pos('[Decrescente]', LstOrdem.Items[i]) - 2)) + ' DESC' + Sulfixo);
    end
    else
    begin
      if Pos('[Crescente]', LstOrdem.Items[i]) > 0 then
        MemScript.Lines.Add('         ' + Acha_Indice(Copy(LstOrdem.Items[i], 1,
          Pos('[Crescente]', LstOrdem.Items[i]) - 2)) + Sulfixo)
      else
        MemScript.Lines.Add('         ' + Acha_Indice(Copy(LstOrdem.Items[i], 1,
          Pos('[Decrescente]', LstOrdem.Items[i]) - 2)) + ' DESC' + Sulfixo);
    end;
  end;

  // Limite de registros no final do comando (Firebird 2.0 ou superior)
  if (LstTabelas_Selecionadas.Count > 0) and (FVersao.LimiteFim(Quantidade) <> '') then
    MemScript.Lines.Add(FVersao.LimiteFim(Quantidade));
end;

function TFrmPrincipal.E_View(const ATabela: String): Boolean;
begin
  Query.SQL.Text :=
    'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ' + QuotedStr(ATabela);
  Query.Open;

  Result := not Query.IsEmpty;

  Query.Close;
end;

function TFrmPrincipal.eh_view: Boolean;
begin
  Result := (LstTabelas_Selecionadas.Count = 1) and
    E_View(Nome_Tabela(LstTabelas_Selecionadas.Items[0]));
end;

// Uma view só pode ser selecionada sozinha (nem repetida com apelido)
function TFrmPrincipal.Verifica_View: Boolean;
var
  i: Integer;
begin
  Result := True;

  if LstTabelas_Selecionadas.Count > 0 then
  begin
    For i := 0 to LstTabelas_Selecionadas.Items.Count - 1 do
    begin
      if E_View(Nome_Tabela(LstTabelas_Selecionadas.Items[i])) then
        Exit(False);
    end;

    Result := not E_View(CmbTabelas.Items[CmbTabelas.ItemIndex]);
  end;
end;

function TFrmPrincipal.Tabela_Selecionada(const ATabela: String): Boolean;
begin
  Result := False;
  for var i := 0 to LstTabelas_Selecionadas.Count - 1 do
    if Nome_Tabela(LstTabelas_Selecionadas.Items[i]) = ATabela then
      Exit(True);
end;

// Apelido para a tabela adicionada novamente: TABELA_2, TABELA_3...
// respeitando o tamanho máximo de identificadores da versão do banco
function TFrmPrincipal.Novo_Apelido(const ATabela: String): String;
var
  Tamanho_Maximo, Sequencia: Integer;
  Sulfixo: String;

  function Apelido_Em_Uso(const AApelido: String): Boolean;
  begin
    Result := CmbTabelas.Items.IndexOf(AApelido) <> -1;
    for var i := 0 to LstTabelas_Selecionadas.Count - 1 do
      if Apelido_Tabela(LstTabelas_Selecionadas.Items[i]) = AApelido then
        Exit(True);
  end;

begin
  if FVersao.Versao >= 40 then
    Tamanho_Maximo := 63
  else
    Tamanho_Maximo := 31;

  Sequencia := 1;
  repeat
    Inc(Sequencia);
    Sulfixo := '_' + IntToStr(Sequencia);
    Result := Copy(ATabela, 1, Tamanho_Maximo - Length(Sulfixo)) + Sulfixo;
  until not Apelido_Em_Uso(Result);
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Fundo.Free;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FAppPathName := ExtractFilePath(ParamStr(0));
  pnlTables.Enabled := False;
  PageControlSQL.Enabled := False;
  Fundo := TFormFundo.CreateNew(Self, True);

  // Abre Configurações de Conexão
  LoadConnection;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  PageControlSQL.ActivePageIndex := 0;
  PCCondicao_Ordem.ActivePageIndex := 0;
  GBCampos_Selecionados.ActivePageIndex := 0;

  CmbOrdem.ItemIndex := 0;
  CmbCondicao.ItemIndex := 0;
  CmbCondicao_Agregados.ItemIndex := 0;
  CmbFuncao.ItemIndex := 0;
end;

procedure TFrmPrincipal.BtnAddClick(Sender: TObject);
var
  Funcao: String;
begin
  if LstCampos.ItemIndex <> -1 then
  begin
    if GBCampos_Selecionados.ActivePageIndex = 0 then
    begin
      if LstTabelas_Selecionadas.ItemIndex <> -1 then
      begin
        if LstCampos_Selecionados.Items.IndexOf
          (Apelido_Tabela(LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex]) +
          '.' + LstCampos.Items[LstCampos.ItemIndex]) = -1 then
        begin
          LstCampos_Selecionados.Items.Add(Apelido_Tabela(LstTabelas_Selecionadas.Items
            [LstTabelas_Selecionadas.ItemIndex]) + '.' + LstCampos.Items
            [LstCampos.ItemIndex]);
        end;

        if LstCampos.ItemIndex < LstCampos.Items.Count - 1 then
        begin
          LstCampos.ItemIndex := LstCampos.ItemIndex + 1;
          LstCampos.Selected[LstCampos.ItemIndex] := True;
        end;
      end
      else
      begin
        MessageDlg('Selecione a tabela', MtInformation, [mbok], 0);
      end;
    end
    else
    begin
      if CmbFuncao.ItemIndex <> -1 then
      begin
        if CmbFuncao.Text = 'Contar' then
        begin
          Funcao := 'COUNT(';
        end
        else if CmbFuncao.Text = 'Máximo' then
        begin
          Funcao := 'MAX(';
        end
        else if CmbFuncao.Text = 'Média' then
        begin
          Funcao := 'AVG(';
        end
        else if CmbFuncao.Text = 'Mínimo' then
        begin
          Funcao := 'MIN(';
        end
        else if CmbFuncao.Text = 'Soma' then
        begin
          Funcao := 'SUM(';
        end;

        if LstTabelas_Selecionadas.ItemIndex <> -1 then
        begin
          LstCampos_Agregados.Items.Add(Funcao + Apelido_Tabela(LstTabelas_Selecionadas.Items
            [LstTabelas_Selecionadas.ItemIndex]) + '.' + LstCampos.Items
            [LstCampos.ItemIndex] + ')');

          if LstCampos_Agregados.ItemIndex < LstCampos_Agregados.Items.Count - 1
          then
          begin
            LstCampos_Agregados.ItemIndex := LstCampos_Agregados.ItemIndex + 1;
            LstCampos_Agregados.Selected[LstCampos_Agregados.ItemIndex] := True;
          end;
        end
        else
        begin
          MessageDlg('Selecione a tabela', MtInformation, [mbok], 0);
        end;
      end;
    end;
  end;

  PCCondicao_OrdemChange(PCCondicao_Ordem);
end;

procedure TFrmPrincipal.btnConectarClick(Sender: TObject);
begin
  Conectar(CDS_CNN.FieldByName('CNN_TYPE').AsString, Cxo,
    CDS_CNN.FieldByName('CNN_SERVER').AsString,
    CDS_CNN.FieldByName('CNN_DATABASE').AsString,
    CDS_CNN.FieldByName('CNN_USERNAME').AsString,
    CDS_CNN.FieldByName('CNN_PASSWORD').AsString,
    CDS_CNN.FieldByName('CNN_PORT').AsInteger);

  if not Cxo.Connected then
    Exit;

  // Em bancos antigos o RDB$SYSTEM_FLAG das tabelas do usuário pode ser nulo
  Query.SQL.Text :=
    'SELECT RDB$RELATION_NAME FROM RDB$RELATIONS ' +
    'WHERE (RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) ' +
    'ORDER BY RDB$RELATION_NAME';
  Query.Open;
  CmbTabelas.Clear;
  while not Query.Eof do
  begin
    CmbTabelas.Items.Add(Trim(Query.FieldByName('RDB$RELATION_NAME').AsString));
    Query.Next;
  end;
  Query.Close;
  CmbCondicao.ItemIndex := 0;

end;

procedure TFrmPrincipal.ApplicationEvents1ModalBegin(Sender: TObject);
begin
  if Assigned(Fundo) then
    Fundo.Exibir(nil, False, EmptyStr, False, False);
end;

procedure TFrmPrincipal.ApplicationEvents1ModalEnd(Sender: TObject);
begin
  if Assigned(Fundo) then
    Fundo.Fechar;
end;

procedure TFrmPrincipal.BtnAddAllClick(Sender: TObject);
var
  i: Integer;
begin
  if LstTabelas_Selecionadas.ItemIndex = -1 then
  begin
    MessageDlg('Selecione a tabela', MtInformation, [mbok], 0);
    Exit;
  end;

  For i := 0 to LstCampos.Count - 1 do
  begin
    if LstCampos_Selecionados.Items.IndexOf(Apelido_Tabela(LstTabelas_Selecionadas.Items
      [LstTabelas_Selecionadas.ItemIndex]) + '.' + LstCampos.Items[i]) = -1 then
    begin
      LstCampos_Selecionados.Items.Add(Apelido_Tabela(LstTabelas_Selecionadas.Items
        [LstTabelas_Selecionadas.ItemIndex]) + '.' + LstCampos.Items[i]);
    end;
  end;
end;

procedure TFrmPrincipal.BtnRemClick(Sender: TObject);
begin
  if GBCampos_Selecionados.ActivePageIndex = 0 then
  begin
    if LstCampos_Selecionados.ItemIndex <> -1 then
    begin
      LstCampos_Selecionados.DeleteSelected;

      if LstCampos_Selecionados.Count > 0 then
      begin
        LstCampos_Selecionados.ItemIndex :=
          LstCampos_Selecionados.Items.Count - 1;
        LstCampos_Selecionados.Selected
          [LstCampos_Selecionados.ItemIndex] := True;
      end;
    end;
  end
  else
  begin
    if LstCampos_Agregados.ItemIndex <> -1 then
    begin
      LstCampos_Agregados.DeleteSelected;

      if LstCampos_Agregados.Count > 0 then
      begin
        LstCampos_Agregados.ItemIndex := LstCampos_Agregados.Items.Count - 1;
        LstCampos_Agregados.Selected[LstCampos_Agregados.ItemIndex] := True;
      end;
    end;
  end;

  PCCondicao_OrdemChange(PCCondicao_Ordem);
end;

procedure TFrmPrincipal.BtnRemAllClick(Sender: TObject);
begin
  if MessageDlg('Confirma a remoção de todas as tabelas?', MtConfirmation,
    [mbyes, mbno], 0) = MrYes then
  begin
    LstTabelas_Selecionadas.Clear;
    LstCampos_Selecionados.Clear;
    LstCampos_Agregados.Clear;
    LstCampos.Clear;
    LstCampos_Filtro.Clear;
    LstOrdem.Clear;
    LstFiltro_Campos_Agregados.Clear;
    LstFiltro.Clear;
    MemPlan.Clear;
    MemScript.Clear;

    PCCondicao_OrdemChange(PCCondicao_Ordem);
  end;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  Condicao: String;
begin
  if PCCondicao_Ordem.ActivePageIndex in [0, 1] then
  begin
    if LstCampos_Filtro.ItemIndex <> -1 then
    begin
      if InputQuery('Adicionar Condição', 'Valor:', Condicao) then
      begin
        if PCCondicao_Ordem.ActivePageIndex = 0 then
        begin
          LstFiltro.Items.Add(LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex]
            + ' "' + CmbCondicao.Items[CmbCondicao.ItemIndex] + '" [' +
            Condicao + ']');
        end
        else if PCCondicao_Ordem.ActivePageIndex = 1 then
        begin
          LstFiltro_Campos_Agregados.Items.Add
            (LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] + ' "' +
            CmbCondicao_Agregados.Items[CmbCondicao_Agregados.ItemIndex] + '" ['
            + Condicao + ']');
        end;
      end;
    end
    else
    begin
      MessageDlg('Selecione um Campo para filtragem', MtInformation, [mbok], 0);
    end;
  end
  else if PCCondicao_Ordem.ActivePageIndex = 2 then
  begin
    if LstCampos_Filtro.ItemIndex <> -1 then
    begin
      LstOrdem.Items.Add(LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] +
        ' [' + CmbOrdem.Text + ']');
    end
    else
    begin
      MessageDlg('Selecione um Campo para Ordenação', MtInformation, [mbok], 0);
    end;
  end;
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
  if PCCondicao_Ordem.ActivePageIndex = 0 then
  begin
    LstFiltro.DeleteSelected;
  end
  else if PCCondicao_Ordem.ActivePageIndex = 1 then
  begin
    LstFiltro_Campos_Agregados.DeleteSelected;
  end
  else if PCCondicao_Ordem.ActivePageIndex = 2 then
  begin
    LstOrdem.DeleteSelected;
  end;
end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
begin
  if PCCondicao_Ordem.ActivePageIndex = 0 then
  begin
    if (LstCampos_Filtro.ItemIndex <> -1) and (CmbCondicao.ItemIndex < 4) then
    begin
      LstFiltro.Items.Add(LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] +
        ' "' + CmbCondicao.Items[CmbCondicao.ItemIndex] + '" [:' +
        Copy(LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex],
        Pos('.', LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex]) + 1,
        Length(LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex])) + ']');
    end;
  end;
end;

procedure TFrmPrincipal.PageControlSQLChange(Sender: TObject);
var
  i: Integer;
  Parametro: String;
  Posicao_Plan: Integer;
begin
  if PageControlSQL.ActivePageIndex = 1 then
  begin
    BtnGera_SqlClick(BtnGera_Sql);
    BtnPreparaClick(BtnPrepara);

    if Trim(MemScript.Text) <> '' then
    begin
      if not eh_view and (Trim(MemPlan.Text) <> '') then
      begin
        // O PLAN deve vir antes do ORDER BY e do limite (ROWS / FETCH FIRST)
        Posicao_Plan := Pos('ORDER BY', MemScript.Text);
        if (Posicao_Plan = 0) and (FVersao.LimiteFim(Trim(EdtFirst.Text)) <> '') and
          not ChkTodos.Checked then
          Posicao_Plan := Pos(FVersao.LimiteFim(Trim(EdtFirst.Text)), MemScript.Text);

        if Posicao_Plan > 0 then
        begin
          Query_Relatorio.SQL.Text := Copy(MemScript.Text, 1,
            Posicao_Plan - 1) + #13 + MemPlan.Text + #13 +
            Copy(MemScript.Text, Posicao_Plan, Length(MemScript.Text));
        end
        else
        begin
          Query_Relatorio.SQL.Text := MemScript.Text + #13 + MemPlan.Text;
        end;
      end
      else
      begin
        Query_Relatorio.SQL.Text := MemScript.Text;
      end;

      For i := 0 to Query_Relatorio.ParamCount - 1 do
      begin
        Parametro := '';

        if InputQuery('Digite valor do Parâmetro',
          Query_Relatorio.Params[i].Name, Parametro) then
        begin
          Query_Relatorio.Params[i].Value := Parametro;
        end
        else
        begin
          Exit;
        end;
      end;

      Query_Relatorio.Open;
    end;
  end
  else
  begin
    Query_Relatorio.Close;
  end;
end;

procedure TFrmPrincipal.LoadConnection;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'Connection.xml') then
  begin
    CDS_CNN.Close;
    CDS_CNN.CreateDataSet;
    CDS_CNN.LoadFromFile(FAppPathName + 'Connection.xml');
    CDS_CNN.Open;
    CDS_CNN.First;

    Combo_Connection.Clear;
    while not CDS_CNN.Eof do
    begin
      Combo_Connection.Items.Add(CDS_CNN.FieldByName('CNN_Name').AsString);
      CDS_CNN.Next;
    end;
    Combo_Connection.ItemIndex := 0;
    Combo_ConnectionChange(Self);
  end
  else
  begin
    CDS_CNN.CreateDataSet;
  end;
end;

procedure TFrmPrincipal.LstCampos_AgregadosDblClick(Sender: TObject);
var
  Linha: String;
begin
  if LstCampos_Agregados.ItemIndex <> -1 then
  begin
    Linha := LstCampos_Agregados.Items[LstCampos_Agregados.ItemIndex];

    if InputQuery('Alterar campo agregado', 'Campo Agregado', Linha) then
    begin
      LstCampos_Agregados.Items[LstCampos_Agregados.ItemIndex] := Linha;
    end;
  end;
end;

procedure TFrmPrincipal.PCCondicao_OrdemChange(Sender: TObject);
var
  i: Integer;
begin
  if PCCondicao_Ordem.ActivePageIndex = 0 then
  begin
    LstCampos_Filtro.Clear;

    if LstTabelas_Selecionadas.ItemIndex = -1 then
    begin
      if LstTabelas_Selecionadas.Items.Count > 0 then
      begin
        LstTabelas_Selecionadas.ItemIndex := 0;
      end;
    end;

    if LstTabelas_Selecionadas.ItemIndex <> -1 then
    begin
      Query.SQL.Text :=
        ' SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS' +
        ' WHERE (RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) AND RDB$RELATION_NAME = '
        + QuotedStr(Nome_Tabela(LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex])) +
        ' ORDER BY RDB$FIELD_POSITION';
      Query.Open;

      while not Query.Eof do
      begin
        LstCampos_Filtro.Items.Add
          (Trim(Apelido_Tabela(LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex])
          + '.' + Query.FieldByName('RDB$FIELD_NAME').AsString));

        Query.Next;
      end;

      Query.Close;
    end;
  end
  else if PCCondicao_Ordem.ActivePageIndex = 1 then
  begin
    LstCampos_Filtro.Items := LstCampos_Agregados.Items;
  end
  else if PCCondicao_Ordem.ActivePageIndex = 2 then
  begin
    LstCampos_Filtro.Clear;

    for i := 0 to LstCampos_Selecionados.Items.Count - 1 do
    begin
      LstCampos_Filtro.Items.Add(LstCampos_Selecionados.Items[i]);
    end;

    for i := 0 to LstCampos_Agregados.Items.Count - 1 do
    begin
      LstCampos_Filtro.Items.Add(LstCampos_Agregados.Items[i]);
    end;
  end;
end;

procedure TFrmPrincipal.LstFiltroDblClick(Sender: TObject);
var
  Linha: String;
begin
  if LstFiltro.ItemIndex <> -1 then
  begin
    Linha := LstFiltro.Items[LstFiltro.ItemIndex];

    if InputQuery('Alterar Condição', 'Condição:', Linha) then
    begin
      LstFiltro.Items[LstFiltro.ItemIndex] := Linha;
    end;
  end;
end;

procedure TFrmPrincipal.LstFiltro_Campos_AgregadosDblClick(Sender: TObject);
var
  Linha: String;
begin
  if LstFiltro_Campos_Agregados.ItemIndex <> -1 then
  begin
    Linha := LstFiltro_Campos_Agregados.Items
      [LstFiltro_Campos_Agregados.ItemIndex];

    if InputQuery('Alterar condição campo agregado', 'Condição', Linha) then
    begin
      LstFiltro_Campos_Agregados.Items
        [LstFiltro_Campos_Agregados.ItemIndex] := Linha;
    end;
  end;
end;

procedure TFrmPrincipal.CDS_CNNAfterDelete(DataSet: TDataSet);
begin
  SaveConnection;
  LoadConnection;
end;

procedure TFrmPrincipal.CDS_CNNAfterInsert(DataSet: TDataSet);
begin
  FrmConnection := TFrmConnection.Create(Self);
  FrmConnection.Left := pnCONN.Left;
  FrmConnection.Width := pnCONN.Width;
  FrmConnection.Top := (pnCONN.Top + pnCONN.Height + 28);
  FrmConnection.ShowModal;
end;

procedure TFrmPrincipal.CDS_CNNAfterPost(DataSet: TDataSet);
begin
  SaveConnection;
  LoadConnection;
end;

procedure TFrmPrincipal.CDS_CNNBeforePost(DataSet: TDataSet);
begin
  CDS_CNN.FieldByName('CNN_NAME').AsString := '[ ' +
    UpperCase(CDS_CNN.FieldByName('CNN_TYPE').AsString) + ' ] ' +
    CDS_CNN.FieldByName('CNN_NAME').AsString;
end;

procedure TFrmPrincipal.CDS_CNNNewRecord(DataSet: TDataSet);
begin
  CDS_CNN.FieldByName('CNN_TYPE').AsString := 'MSSQL';
  CDS_CNN.FieldByName('CNN_SERVER').AsString := 'LOCALHOST';
  CDS_CNN.FieldByName('CNN_NAME').AsString := 'Conexão Local ';
end;

procedure TFrmPrincipal.ChkTodosClick(Sender: TObject);
begin
  if not ChkTodos.Checked then
  begin
    if EdtFirst.Text = '0' then
    begin
      UDFirst.Position := 10;
    end;
  end;
end;

procedure TFrmPrincipal.Combo_ConnectionChange(Sender: TObject);
begin
  CDS_CNN.Locate('CNN_NAME', Combo_Connection.Text, []);
end;

procedure TFrmPrincipal.Conectar(Driver: String; Conn: TFDConnection;
  Server, Database, User, Pass: String; Port: Integer);
const
  DBOracle =
    '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=%s)(PORT=%s))(CONNECT_DATA=(SERVICE_NAME=XE)))';
begin
  Conn.Connected := False;
  if (Driver = 'MSSQL') then
  begin
    Conn.Params.Clear;
    Conn.DriverName := 'MSSQL';
    Conn.Params.DriverID := 'MSSQL';
    Conn.Params.Values['Server'] := Server;
    Conn.Params.Values['DataBase'] := Database;
    if (Length(Trim(User)) = 0) and (Length(Trim(Pass)) = 0) then
    begin
      Conn.Params.Values['OSAuthent'] := 'Yes';
      Conn.Params.Values['User_Name'] := ''; // User;
      Conn.Params.Values['Password'] := ''; // Pass;
    end
    else
    begin
      Conn.Params.Values['OSAuthent'] := 'No';
      Conn.Params.Values['User_Name'] := User;
      Conn.Params.Values['Password'] := Pass;
    end;
    Conn.Params.Values['MetaDefSchema'] := 'dbo';
    Conn.Params.Values['MetaDefCatalog'] := Database;
    Conn.Params.Values['DriverID'] := 'MSSQL';
  end
  else if (Driver = 'Firebird') then
  begin
    Conn.Params.Clear;
    Conn.DriverName := 'FB';
    Conn.Params.DriverID := 'FB';
    Conn.Params.Values['DriverID'] := 'FB';
    Conn.Params.Values['Server'] := Server;
    if Port > 0 then
      Conn.Params.Values['Port'] := IntToStr(Port);
    Conn.Params.Values['DataBase'] := Database;
    Conn.Params.Values['User_Name'] := User;
    Conn.Params.Values['Password'] := Pass;
  end
  else if (Driver = 'Interbase') then
  begin
    Conn.Params.Clear;
    Conn.DriverName := 'IB';
    Conn.Params.DriverID := 'IB';
    Conn.Params.Values['DriverID'] := 'IB';
    Conn.Params.Values['Server'] := Server;
    if Port > 0 then
      Conn.Params.Values['Port'] := IntToStr(Port);
    Conn.Params.Values['DataBase'] := Database;
    Conn.Params.Values['User_Name'] := User;
    Conn.Params.Values['Password'] := Pass;
  end
  else if (Driver = 'Oracle') then
  begin
    Conn.Params.Clear;
    Conn.DriverName := 'Ora';
    Conn.Params.DriverID := 'Ora';
    Conn.Params.Values['DataBase'] :=
      Format(DBOracle, [Server, IntToStr(Port)]);
    Conn.Params.Values['User_Name'] := User;
    Conn.Params.Values['Password'] := Pass;
  end
  else if (Driver = 'MySQL') then
  begin
    Conn.Params.Clear;
    Conn.DriverName := 'MySQL';
    Conn.Params.DriverID := 'MySQL';
    Conn.Params.Values['Server'] := Server;
    if Port > 0 then
      Conn.Params.Values['Port'] := IntToStr(Port);
    Conn.Params.Values['DataBase'] := Database;
    Conn.Params.Values['User_Name'] := User;
    Conn.Params.Values['Password'] := Pass;
  end
  else if (Driver = 'SQLite') then
  begin
    Conn.DriverName := 'SQLite';
    Conn.Params.Clear;
    Conn.Params.DriverID := 'SQLite';
    Conn.Params.Values['HostName'] := '';
    Conn.Params.Values['DataBase'] := Database;
    Conn.Params.Values['User_Name'] := '';
    Conn.Params.Values['Password'] := '';
  end
  else if (Driver = 'PostgreSQL') then
  begin
    Conn.DriverName := 'PG';
    Conn.Params.Clear;
    Conn.Params.DriverID := 'PG';
    Conn.Params.Values['Server'] := Server;
    if Port > 0 then
      Conn.Params.Values['Port'] := IntToStr(Port);
    Conn.Params.Values['DataBase'] := Database;
    Conn.Params.Values['User_Name'] := User;
    Conn.Params.Values['Password'] := Pass;
  end;
  Conn.Connected := True;
  // Metadata.Connection                    := Conn;
end;

procedure TFrmPrincipal.CxoAfterConnect(Sender: TObject);
begin
  pnlTables.Enabled := True;
  PageControlSQL.Enabled := True;

  // Versão do Firebird em que o banco foi criado, para gerar SQL compatível
  FVersao := TFirebirdVersao.Detectar(Cxo);
  if FVersao.Detectada then
    Panel9.Caption := 'Conexões - ' + FVersao.Descricao
  else
    Panel9.Caption := 'Conexões';
end;

procedure TFrmPrincipal.LstTabelas_SelecionadasClick(Sender: TObject);
begin
  if LstTabelas_Selecionadas.ItemIndex <> -1 then
  begin
    Query.SQL.Text :=
      ' SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS' +
      ' WHERE (RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) AND RDB$RELATION_NAME = '
      + QuotedStr(Nome_Tabela(LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex])) +
      ' ORDER BY RDB$FIELD_POSITION';
    Query.Open;

    LstCampos.Clear;

    while not Query.Eof do
    begin
      LstCampos.Items.Add(Trim(Query.FieldByName('RDB$FIELD_NAME').AsString));

      Query.Next;
    end;

    Query.Close;

    LbCampos.Caption := 'Campos - ' + LstTabelas_Selecionadas.Items
      [LstTabelas_Selecionadas.ItemIndex];
  end
  else
  begin
    LbCampos.Caption := 'Campos';
  end;

  PCCondicao_OrdemChange(PCCondicao_Ordem);
end;

procedure TFrmPrincipal.Button4Click(Sender: TObject);
var
  Tabela, Apelido: String;
begin
  if CmbTabelas.ItemIndex = -1 then
    Exit;

  if not Verifica_View then
  begin
    MessageDlg('Uma view só pode ser selecionada sozinha', MtInformation,
      [mbok], 0);
    Exit;
  end;

  Tabela := CmbTabelas.Items[CmbTabelas.ItemIndex];

  if not Tabela_Selecionada(Tabela) then
  begin
    LstTabelas_Selecionadas.Items.Add(Tabela);
  end
  else
  begin
    // A mesma tabela pode entrar mais de uma vez (ex.: dois campos que referenciam
    // PESSOA). Cada ocorrência recebe um apelido e usa outra chave estrangeira
    Apelido := Novo_Apelido(Tabela);

    if MessageDlg('A tabela ' + Tabela + ' já foi adicionada.' + sLineBreak +
      'Deseja adicioná-la novamente com o apelido ' + Apelido + '?' + sLineBreak +
      sLineBreak + 'Use quando mais de um campo referencia esta tabela: ' +
      'cada ocorrência será ligada por uma chave estrangeira diferente.',
      MtConfirmation, [mbyes, mbno], 0) = MrYes then
    begin
      LstTabelas_Selecionadas.Items.Add(Tabela + ' ' + Apelido);
    end;
  end;
end;

procedure TFrmPrincipal.Button5Click(Sender: TObject);
begin
  LstTabelas_Selecionadas.DeleteSelected;

  if LstTabelas_Selecionadas.Items.Count = 0 then
  begin
    LbCampos.Caption := 'Campos';
  end;

  LstCampos.Clear;
end;

procedure TFrmPrincipal.Button6Click(Sender: TObject);
var
  Temp: String;
begin
  if (LstTabelas_Selecionadas.ItemIndex > 0) then
  begin
    Temp := LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex];
    LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] :=
      LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex - 1];
    LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex -
      1] := Temp;

    LstTabelas_Selecionadas.ItemIndex := LstTabelas_Selecionadas.ItemIndex - 1;

    LstTabelas_SelecionadasClick(LstTabelas_Selecionadas);
  end;
end;

procedure TFrmPrincipal.BtnGera_SqlClick(Sender: TObject);
begin
  Gera_Script;
end;

procedure TFrmPrincipal.BtnPreparaClick(Sender: TObject);
begin
  // if Trim( MemScript.Text ) <> '' then
  // begin
  // IBSQL.SQL.Text := MemScript.Text;
  //
  // Try
  // IBSQL.Prepare;
  // except
  // On E: Exception do
  // begin
  // MemPlan.Clear;
  // MemPlan.Text := E.Message;
  // end;
  // end;
  //
  // if IBSQL.Prepared then
  // begin
  // MemPlan.lines.Text := IBSQL.Plan;
  // end;
  // end
  // else
  // begin
  // MemPlan.lines.Clear;
  // end;
end;

procedure TFrmPrincipal.SaveConnection;
begin
  CDS_CNN.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Connection.xml', dfXML);
end;

procedure TFrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  Clipboard.AsText := MemScript.Text;
end;

end.
