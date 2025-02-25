unit Frm_Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  IBDatabase, ComCtrls, Grids, DBGrids, IBSQL, FireDAC.UI.Intf,
  FireDAC.VCLUI.Login, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  Vcl.DBCtrls, FireDAC.Phys.IBBase, Datasnap.DBClient, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.AppEvnts,

  Frm_Fundo;

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
    IBSQL_: TIBSQL;
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
    procedure Query_JoinFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    Indice_Filtro: Integer;
    FAppPathName: String;
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
  Vcl.Clipbrd,
  Frm_Connection,
  Log;

{$R *.dfm}

procedure TFrmPrincipal.Gera_Script;
var
  i, j, k: Integer;
  Lst_Temp: TStringList;
  Constraint: String;
  Script_Temp, Nome_Tabela_Relacionada: String;
  Paragrafo: String;
  Achou, From_Used: Boolean;
  Tabela_Selecionada: String;
  Inner_Ou_Left: String;
  Where: String;
  Operacao: String;
  Prefixo, Sulfixo: String;
  First: String;
  Tabelas_Selecionadas: String;
  Linha_Temp: String;

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

  if (LstTabelas_Selecionadas.Count > 0) then
  begin
    Lst_Temp := TStringList.Create;
    Lista_Joins.Clear;

    // Adicionando os n Primeiros
    if not ChkTodos.Checked then
      First := 'FIRST ' + EdtFirst.Text
    else
      First := '';

    MemScript.Lines.Add('SELECT ' + First);

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
    begin
      Script_Temp := '';
      Inner_Ou_Left := '';

      // Selecionando as constraints (a tabela é filtrada no evento OnFilterRecord)
      var LSqlConstraints := '''
        SELECT
          RRC.RDB$CONSTRAINT_NAME NOME_CONSTRAINT, RRC.RDB$INDEX_NAME, RRC.RDB$RELATION_NAME, RIS.RDB$FIELD_NAME CAMPO, RIS.RDB$FIELD_POSITION,
          (SELECT RI2.RDB$RELATION_NAME FROM RDB$INDICES RI2 WHERE RI2.RDB$INDEX_NAME = RI.RDB$FOREIGN_KEY ) TABELA_RELACIONADA,
          (SELECT RIS2.RDB$FIELD_NAME FROM RDB$INDEX_SEGMENTS RIS2 INNER JOIN RDB$INDICES RI2 ON RIS2.RDB$INDEX_NAME = RI2.RDB$INDEX_NAME
           WHERE RI2.RDB$INDEX_NAME = RI.RDB$FOREIGN_KEY AND RIS2.RDB$FIELD_POSITION = RIS.RDB$FIELD_POSITION ) CAMPO_RELACIONADO
        FROM RDB$RELATION_CONSTRAINTS RRC
          INNER JOIN RDB$INDEX_SEGMENTS RIS ON RIS.RDB$INDEX_NAME = RRC.RDB$INDEX_NAME
          INNER JOIN RDB$INDICES RI ON RI.RDB$INDEX_NAME = RRC.RDB$INDEX_NAME
        WHERE RRC.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
        ORDER BY 6, RRC.RDB$CONSTRAINT_NAME, RIS.RDB$FIELD_POSITION
        ''';
      Query_Join.SQL.Text := LSqlConstraints;
      CodeSite.Send('Query_Join', Query_Join.SQL.Text);
      Query_Join.Open;

      For i := 0 to Pred(LstTabelas_Selecionadas.Items.Count) do
      begin
        Query_Join.First;
        LstTabelas_Selecionadas.ItemIndex := i;

        // Armazenando o índice para o filtro no OnFilterRecord
        Indice_Filtro := i;

        Nome_Tabela_Relacionada := '';

        // Armazenando o nome da constraint para verificar a mudança de join
        Constraint := Query_Join.FieldByName('NOME_CONSTRAINT').AsString;

        while not Query_Join.Eof do
        begin
          // Verificando se a tabela Relacionada está no rol das tabelas Selecionadas, se estiver então...
          if LstTabelas_Selecionadas.Items.IndexOf(Trim(Query_Join.FieldByName('RDB$RELATION_NAME').AsString)) <> -1 then
          begin
            // Verificando se um dos campos admite nulo
            var LSqlCampoNulo := '''
              SELECT
                *
              FROM RDB$RELATION_FIELDS, RDB$FIELDS
              WHERE
                RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE AND
                RDB$RELATION_FIELDS.RDB$RELATION_NAME = %s AND
                RDB$RELATION_FIELDS.RDB$FIELD_NAME = %s
              ''';

            // Verificando o 1º Campo
            Query2.SQL.Text := Format(LSqlCampoNulo,
              [QuotedStr(Trim(Query_Join.FieldByName('TABELA_RELACIONADA').AsString)),
               QuotedStr(Trim(Query_Join.FieldByName('CAMPO_RELACIONADO').AsString))]);
            CodeSite.Send('Query2', Query2.SQL.Text);
            Query2.Open;

            if (Query2.FieldByName('RDB$NULL_FLAG').AsString = '') then
            begin
              // armazenando o tipo de ligação
              Inner_Ou_Left := 'LEFT JOIN';
            end else
            begin

              // Verificando o 2º Campo
              Query2.SQL.Text := Format(LSqlCampoNulo,
                [QuotedStr(Trim(Query_Join.FieldByName('RDB$RELATION_NAME').AsString)),
                 QuotedStr(Trim(Query_Join.FieldByName('CAMPO').AsString))]);
              CodeSite.Send('Query2', Query2.SQL.Text);
              Query2.Open;

              if (Query2.FieldByName('RDB$NULL_FLAG').AsString = '') then
                Inner_Ou_Left := 'LEFT JOIN'
              else
              begin
                if (Inner_Ou_Left = '') then
                begin
                  Inner_Ou_Left := 'INNER JOIN';
                end;
              end;
            end;
            Query2.Close;

            // Verifica se a Tabela Relacionada está listagem de tabelas selecionadas
            if LstTabelas_Selecionadas.Items.IndexOf(Query_Join.FieldByName('TABELA_RELACIONADA').AsString) < 0 then
            begin
              Query_Join.Next;
              Continue;
            end;

            // Se for o primeiro campo de uma chave composta então armazene na variável...
            if (Query_Join.FieldByName('RDB$FIELD_POSITION').AsInteger = 0) then
            begin
              // é adicionado o nome "TABELA" para podermos adicionar mais tarde o nome da tabela
              // O caracter "|" é para marcar a posição da relação INNER ou LEFT
              Script_Temp :=
                ' |TABELA ON ' + LstTabelas_Selecionadas.Items[i] + '.' +
                Trim(Query_Join.FieldByName('CAMPO_RELACIONADO').AsString) + ' = ' +
                Trim(Query_Join.FieldByName('RDB$RELATION_NAME').AsString) + '.' +
                Trim(Query_Join.FieldByName('CAMPO').AsString);
            end
            else
            // Se não for o primeiro campo de uma chave composta então adicione o resto do join...
            begin
              Script_Temp :=
                Script_Temp + ' AND ' +
                LstTabelas_Selecionadas.Items[i] + '.' +
                Trim(Query_Join.FieldByName('CAMPO_RELACIONADO').AsString) + ' = ' +
                Trim(Query_Join.FieldByName('RDB$RELATION_NAME').AsString) + '.' +
                Trim(Query_Join.FieldByName('CAMPO').AsString);
            end;

            // Esta variável será adicionada na frente do JOIN indicando as tabelas que participam da
            // ligação
            Tabelas_Selecionadas := LstTabelas_Selecionadas.Items[i] + '/' +
              Trim(Query_Join.FieldByName('RDB$RELATION_NAME').AsString);
          end;

          Query_Join.Next;

          // Se esta constraint já foi processada, então vou adicionar numa lista
          if (Constraint <> Query_Join.FieldByName('NOME_CONSTRAINT').AsString) or Query_Join.Eof then
          begin
            if Script_Temp <> '' then
            begin
              // Substituindo | por INNER JOIN ou LEFT JOIN
              while Pos('|', Script_Temp) > 0 do
              begin
                Script_Temp := Copy(Script_Temp, 1, Pos('|', Script_Temp) - 1) +
                  Inner_Ou_Left + Copy(Script_Temp, Pos('|', Script_Temp) + 1,
                  Length(Script_Temp));
              end;

              // Adicionando a ligação na lista. Primeiro coloco os caracteres de controle das tabelas e depois o JOIN propriamente dito
              Lista_Joins.Items.Add(Tabelas_Selecionadas + ':' + Script_Temp);

              Script_Temp := '';

              Inner_Ou_Left := '';
            end;

            // Atualizando no nome da constraint
            Constraint := Query_Join.FieldByName('NOME_CONSTRAINT').AsString;
          end;
        end;
      end;
      Query_Join.Close;

      Paragrafo := '';

      From_Used := False;

      // Criando o join
      For j := 0 to LstTabelas_Selecionadas.Count - 2 do
      begin
        // Inicializando variável de controle
        Achou := False;

        For i := 0 to Lista_Joins.Count - 1 do
        begin
          // Inicialmente a relação é feita entre tabelas sequenciais. A 1º com a 2º, a 2º com a 3º ...
          // Subentende-se que o usuário adicionou as tabelas de forma que a tabela dependente foi
          // selecionada após a tabela principal
          if (Copy(Lista_Joins.Items[i], 1, Pos(':', Lista_Joins.Items[i]) - 1)
            = LstTabelas_Selecionadas.Items[j] + '/' +
            LstTabelas_Selecionadas.Items[j + 1]) or
            (Copy(Lista_Joins.Items[i], 1, Pos(':', Lista_Joins.Items[i]) - 1)
            = LstTabelas_Selecionadas.Items[j + 1] + '/' +
            LstTabelas_Selecionadas.Items[j]) then
          begin
            // O primeiro Join sempre vai ter o FROM desde que não haja duas constraints apontando para a mesma tabela
            if (j = 0) and not From_Used then
            begin
              // Formatando o join, tirando os caracteres de controle
              Lista_Joins.Items[i] := Copy(Lista_Joins.Items[i], 1,
                Pos('TABELA', Lista_Joins.Items[i]) - 1) + ' ' +
                LstTabelas_Selecionadas.Items[j + 1] + ' ' +
                Copy(Lista_Joins.Items[i], Pos('TABELA', Lista_Joins.Items[i]) +
                7, Length(Lista_Joins.Items[i]));
              Linha_Temp := 'FROM ' + LstTabelas_Selecionadas.Items[j] + sLineBreak +
                Copy(Lista_Joins.Items[i], Pos(':', Lista_Joins.Items[i]) + 1,
                Length(Lista_Joins.Items[i]));

              From_Used := True;
            end
            else
            begin
              // Formatando o join, tirando os caracteres de controle
              Lista_Joins.Items[i] := Copy(Lista_Joins.Items[i], 1,
                Pos('TABELA', Lista_Joins.Items[i]) - 1) + ' ' +
                LstTabelas_Selecionadas.Items[j + 1] + ' ' +
                Copy(Lista_Joins.Items[i], Pos('TABELA', Lista_Joins.Items[i]) +
                7, Length(Lista_Joins.Items[i]));
              Linha_Temp := Copy(Lista_Joins.Items[i],
                Pos(':', Lista_Joins.Items[i]) + 2,
                Length(Lista_Joins.Items[i]));
            end;

            // Adicionando o nome das tabelas que já participaram, "dando oportunidade"
            // para as outras tabelas serem mencionadas nos próximos joins
            Lst_Temp.Add(LstTabelas_Selecionadas.Items[j]);
            Lst_Temp.Add(LstTabelas_Selecionadas.Items[j + 1]);

            // Adicionando JOIN ao script com parágrafo
            MemScript.Lines.Add(Paragrafo + Linha_Temp);

            // Aumentando o parágrafo
            Paragrafo := Paragrafo + '      ';

            // Existe uma relação entre as tabelas sequencialmente
            Achou := True;
          end;
        end;

        // Não foi encontrada relação entre tabelas paralelas, então vamos varrer a lista de tabelas
        // Até encontrar a tabela que está relacionada
        if not Achou then
        begin
          For k := 0 to LstTabelas_Selecionadas.Count - 1 do
          begin
            // Não pode ser a mesma tabela usada anteriormente
            if k <> j + 1 then
            begin
              For i := 0 to Lista_Joins.Count - 1 do
              begin
                // Verifica se existe a relação
                if (Copy(Lista_Joins.Items[i], 1, Pos(':', Lista_Joins.Items[i])
                  - 1) = LstTabelas_Selecionadas.Items[j + 1] + '/' +
                  LstTabelas_Selecionadas.Items[k]) or
                  (Copy(Lista_Joins.Items[i], 1, Pos(':', Lista_Joins.Items[i])
                  - 1) = LstTabelas_Selecionadas.Items[k] + '/' +
                  LstTabelas_Selecionadas.Items[j + 1]) then
                begin
                  // Verifica se a tabela já foi adicionada em alguma relação
                  if (Lst_Temp.IndexOf(LstTabelas_Selecionadas.Items[j + 1]) <>
                    -1) or (Lst_Temp.IndexOf(LstTabelas_Selecionadas.Items[k])
                    <> -1) then
                  begin
                    // Pegando o nome da tabela apropriada para o join
                    if Lst_Temp.IndexOf(LstTabelas_Selecionadas.Items[j + 1]
                      ) = -1 then
                      Tabela_Selecionada := LstTabelas_Selecionadas.Items[j + 1]
                    else
                      Tabela_Selecionada := LstTabelas_Selecionadas.Items[k];

                    // Formatando o join, tirando os caracteres de controle
                    Lista_Joins.Items[i] := Copy(Lista_Joins.Items[i], 1,
                      Pos('TABELA', Lista_Joins.Items[i]) - 1) + ' ' +
                      Tabela_Selecionada + ' ' + Copy(Lista_Joins.Items[i],
                      Pos('TABELA', Lista_Joins.Items[i]) + 7,
                      Length(Lista_Joins.Items[i]));
                    Linha_Temp := Copy(Lista_Joins.Items[i],
                      Pos(':', Lista_Joins.Items[i]) + 2,
                      Length(Lista_Joins.Items[i]));

                    // adicionando JOIN ao script com parágrafo
                    MemScript.Lines.Add(Paragrafo + Linha_Temp);

                    // Aumentando o parágrafo
                    Paragrafo := Paragrafo + '      ';
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      Lst_Temp.Free;
    end;
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
end;

function TFrmPrincipal.eh_view: Boolean;
begin
  Result := False;

  if LstTabelas_Selecionadas.Count = 1 then
  begin
    Query.SQL.Text :=
      'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' +
      LstTabelas_Selecionadas.Items[0] + '''';
    Query.Open;

    Result := not Query.IsEmpty;

    Query.Close;
  end;
end;

function TFrmPrincipal.Verifica_View: Boolean;
var
  i: Integer;
begin
  Result := True;

  if LstTabelas_Selecionadas.Count > 0 then
  begin
    For i := 0 to LstTabelas_Selecionadas.Items.Count - 1 do
    begin
      if LstTabelas_Selecionadas.Items[i] <> CmbTabelas.Items
        [CmbTabelas.ItemIndex] then
      begin
        Query.SQL.Text :=
          'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' +
          LstTabelas_Selecionadas.Items[i] + '''';
        Query.Open;

        if not Query.IsEmpty then
        begin
          Result := False;
        end;

        Query.Close;
      end;
    end;

    if Result then
    begin
      if LstTabelas_Selecionadas.Items.IndexOf
        (CmbTabelas.Items[CmbTabelas.ItemIndex]) = -1 then
      begin
        Query.SQL.Text :=
          'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' +
          CmbTabelas.Items[CmbTabelas.ItemIndex] + '''';
        Query.Open;

        Result := Query.IsEmpty;

        Query.Close;
      end;
    end;
  end;
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
          (LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] +
          '.' + LstCampos.Items[LstCampos.ItemIndex]) = -1 then
        begin
          LstCampos_Selecionados.Items.Add(LstTabelas_Selecionadas.Items
            [LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items
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
          LstCampos_Agregados.Items.Add(Funcao + LstTabelas_Selecionadas.Items
            [LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items
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

  Query.SQL.Text := 'SELECT * FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0';
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
  For i := 0 to LstCampos.Count - 1 do
  begin
    if LstCampos_Selecionados.Items.IndexOf(LstTabelas_Selecionadas.Items
      [LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[i]) = -1 then
    begin
      LstCampos_Selecionados.Items.Add(LstTabelas_Selecionadas.Items
        [LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[i]);
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
begin
  if PageControlSQL.ActivePageIndex = 1 then
  begin
    BtnGera_SqlClick(BtnGera_Sql);
    BtnPreparaClick(BtnPrepara);

    if Trim(MemScript.Text) <> '' then
    begin
      if not eh_view then
      begin
        if Pos('ORDER BY', MemScript.Text) > 0 then
        begin
          Query_Relatorio.SQL.Text := Copy(MemScript.Text, 1,
            Pos('ORDER BY', MemScript.Text) - 1) + #13 + MemPlan.Text + #13 +
            Copy(MemScript.Text, Pos('ORDER BY', MemScript.Text),
            Length(MemScript.Text));
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
        ' SELECT * FROM RDB$RELATION_FIELDS WHERE RDB$SYSTEM_FLAG = 0 AND RDB$RELATION_NAME = '''
        + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] +
        ''' ORDER BY RDB$FIELD_POSITION';
      Query.Open;

      while not Query.Eof do
      begin
        LstCampos_Filtro.Items.Add
          (Trim(LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex]
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
end;

procedure TFrmPrincipal.LstTabelas_SelecionadasClick(Sender: TObject);
begin
  if LstTabelas_Selecionadas.ItemIndex <> -1 then
  begin
    Query.SQL.Text :=
      ' SELECT * FROM RDB$RELATION_FIELDS WHERE RDB$SYSTEM_FLAG = 0 AND RDB$RELATION_NAME = '''
      + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] +
      ''' ORDER BY RDB$FIELD_POSITION';
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
begin
  if not Verifica_View then
  begin
    MessageDlg('Uma view só pode ser selecionada sozinha', MtInformation,
      [mbok], 0);
    Exit;
  end;

  if LstTabelas_Selecionadas.Items.IndexOf
    (CmbTabelas.Items[CmbTabelas.ItemIndex]) = -1 then
  begin
    LstTabelas_Selecionadas.Items.Add(CmbTabelas.Items[CmbTabelas.ItemIndex]);
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

procedure TFrmPrincipal.Query_JoinFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if (LstTabelas_Selecionadas.ItemIndex <> -1) and (Indice_Filtro <> -1) then
  begin
    Accept := (LstTabelas_Selecionadas.Items[Indice_Filtro]
      = Trim(Query_Join.FieldByName('TABELA_RELACIONADA').AsString));
  end;
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
