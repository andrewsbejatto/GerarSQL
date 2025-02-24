unit UnitGera_Sql;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  IBDatabase, ComCtrls, Grids, DBGrids, IBSQL, FireDAC.UI.Intf, FireDAC.VCLUI.Login, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TFrmGera_Sql = class(TForm)
    Label1: TLabel;
    LstCampos: TListBox;
    LbCampos: TLabel;
    Label5: TLabel;
    LstTabelas_Selecionadas: TListBox;
    BtnAdd: TButton;
    BtnAddAll: TButton;
    BtnRem: TButton;
    BtnRemAll: TButton;
    CmbTabelas: TComboBox;
    Label6: TLabel;
    LstCampos_Filtro: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    Query: TIBQuery;
    Query2: TIBQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MemScript: TMemo;
    GrdConsulta: TDBGrid;
    DS_Query_Relatorio: TDataSource;
    Query_Relatorio: TIBQuery;
    PCCondicao_Ordem: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    LstFiltro: TListBox;
    CmbCondicao: TComboBox;
    CmbOrdem: TComboBox;
    LstOrdem: TListBox;
    GBCampos_Selecionados: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    LstCampos_Selecionados: TListBox;
    LstCampos_Agregados: TListBox;
    CmbFuncao: TComboBox;
    TabSheet7: TTabSheet;
    LstFiltro_Campos_Agregados: TListBox;
    CmbCondicao_Agregados: TComboBox;
    IBSQL: TIBSQL;
    TabSheet8: TTabSheet;
    EdtFirst: TEdit;
    UDFirst: TUpDown;
    ChkTodos: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    Query_Join: TIBQuery;
    Button6: TButton;
    Panel2: TPanel;
    Lista_Joins: TListBox;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    BtnGera_Sql: TSpeedButton;
    BtnPrepara: TSpeedButton;
    MemPlan: TMemo;
    SpeedButton2: TSpeedButton;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    Cxo: TFDConnection;
    procedure FormShow(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnAddAllClick(Sender: TObject);
    procedure BtnRemClick(Sender: TObject);
    procedure BtnRemAllClick(Sender: TObject);
    function Verifica_View : Boolean;
    function eh_view       : Boolean;
    procedure Gera_Script;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure LstCampos_AgregadosDblClick(Sender: TObject);
    procedure PCCondicao_OrdemChange(Sender: TObject);
    procedure LstFiltroDblClick(Sender: TObject);
    procedure LstFiltro_Campos_AgregadosDblClick(Sender: TObject);
    procedure ChkTodosClick(Sender: TObject);
    procedure LstTabelas_SelecionadasClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Query_JoinFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure BtnGera_SqlClick(Sender: TObject);
    procedure BtnPreparaClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    Indice_Filtro : Integer;
  public
    { Public declarations }
  end;

var
  FrmGera_Sql: TFrmGera_Sql;

implementation

uses
  Vcl.Clipbrd,
  UnitConecta;

{$R *.dfm}


procedure TFrmGera_Sql.Gera_Script;
Var i, j, k : integer;
    Lst_Temp : TStringList;
    Constraint : String;
    Script_Temp, Nome_Tabela_Relacionada : String;
    Paragrafo : String;
    Achou, From_Used : Boolean;
    Tabela_Selecionada : String;
    Inner_Ou_Left : String;
    Where : String;
    Operacao : String;
    Prefixo, Sulfixo : String;
    First : String;
    Tabelas_Selecionadas : String;
    Linha_Temp : String;

    //Acha a posição do campo para o order by
    function Acha_Indice( Campo : String ) : String;
    begin
         if LstCampos_Selecionados.Items.IndexOf( Campo ) <> -1 then
         begin
              Result := IntToStr( LstCampos_Selecionados.Items.IndexOf( Campo ) + 1 );
         end
         else
         begin
              Result := IntToStr( LstCampos_Selecionados.Count + LstCampos_Agregados.Items.IndexOf( Campo ) + 1 );
         end;
    end;
begin
     MemScript.Clear;

     if ( LstTabelas_Selecionadas.Count > 0 ) then
     begin
          Lst_Temp := TSTringList.Create;
          Lista_Joins.Clear;

          //Adicionando os n Primeiros
          if not ChkTodos.Checked then
          begin
               First := 'FIRST ' + EdtFirst.Text;
          end
          else
          begin
               First := '';
          end;

          MemScript.Lines.Add( 'SELECT ' + First );

          //Selecionando os campos a serem exibidos
          if LstCampos_Selecionados.Items.Count + LstCampos_Agregados.Items.Count > 0 then
          begin
               For i := 0 to LstCampos_Selecionados.Items.Count -1 do
               begin
                    if i = LstCampos_Selecionados.Items.Count -1 then
                    begin
                         if LstCampos_Agregados.Items.Count > 0 then
                         begin
                              MemScript.Lines.Add( '      ' + LstCampos_Selecionados.Items[i] + ', ');
                         end
                         else
                         begin
                              MemScript.Lines.Add( '      ' + LstCampos_Selecionados.Items[i] );
                         end;
                    end
                    else
                    begin
                         MemScript.Lines.Add( '      ' + LstCampos_Selecionados.Items[i] + ', ');
                    end;
               end;

               For i := 0 to LstCampos_Agregados.Items.Count -1 do
               begin
                    if i = LstCampos_Agregados.Items.Count -1 then
                    begin
                         MemScript.Lines.Add( '      ' + LstCampos_Agregados.Items[i] );
                    end
                    else
                    begin
                         MemScript.Lines.Add( '      ' + LstCampos_Agregados.Items[i] + ', ');
                    end;
               end;
          end
          else
          begin
               MemScript.Lines.Add( '      *' );
          end;

          //verificar se será selecionada apenas uma tabela ou será necessário fazer ligações
          if LstTabelas_Selecionadas.Items.Count = 1 then
          begin
               MemScript.Lines.Add( 'FROM ' + LstTabelas_Selecionadas.Items[0] );
          end
          else
          begin
               Script_Temp := '';

               Inner_Ou_Left := '';

               For i := 0 to LstTabelas_Selecionadas.Items.Count -1 do
               begin
                    LstTabelas_Selecionadas.ItemIndex := i;

                    //Armazenando o índice para o filtro no OnFilterRecord
                    Indice_Filtro := i;

                    Nome_Tabela_Relacionada := '';

                    //Selecionando as constraints (a tabela é filtrada no evento OnFilterRecord)
                    Query_Join.SQL.Text := ' SELECT RRC.RDB$CONSTRAINT_NAME NOME_CONSTRAINT, RRC.RDB$INDEX_NAME, RRC.RDB$RELATION_NAME, RIS.RDB$FIELD_NAME CAMPO, RIS.RDB$FIELD_POSITION, ' +
                                           ' ( SELECT RI2.RDB$RELATION_NAME ' +
                                           ' FROM RDB$INDICES RI2 ' +
                                           ' WHERE RI2.RDB$INDEX_NAME = RI.RDB$FOREIGN_KEY ) TABELA_RELACIONADA, ' +

                                           ' ( SELECT RIS2.RDB$FIELD_NAME ' +
                                           ' FROM RDB$INDEX_SEGMENTS RIS2 INNER JOIN RDB$INDICES RI2 ON RIS2.RDB$INDEX_NAME = RI2.RDB$INDEX_NAME ' +
                                           ' WHERE RI2.RDB$INDEX_NAME = RI.RDB$FOREIGN_KEY AND ' +
                                           '       RIS2.RDB$FIELD_POSITION = RIS.RDB$FIELD_POSITION ) CAMPO_RELACIONADO ' +

                                           ' FROM RDB$RELATION_CONSTRAINTS RRC ' +
                                           '      INNER JOIN RDB$INDEX_SEGMENTS RIS ON RIS.RDB$INDEX_NAME = RRC.RDB$INDEX_NAME ' +
                                           '            INNER JOIN RDB$INDICES RI ON RI.RDB$INDEX_NAME = RRC.RDB$INDEX_NAME ' +
                                           ' WHERE RRC.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' ORDER BY 6, RRC.RDB$CONSTRAINT_NAME, RIS.RDB$FIELD_POSITION';
                    Query_Join.Open;

                    //Armazenando o nome da constraint para verificar a mudança de join
                    Constraint := Query_Join.FieldByName( 'NOME_CONSTRAINT' ).AsString;

                    while not Query_Join.Eof do
                    begin
                         //Verificando se a tabela Relacionada está no rol das tabelas Selecionadas, se estiver então...
                         if LstTabelas_Selecionadas.Items.IndexOf( Trim( Query_Join.FieldByName( 'RDB$RELATION_NAME' ).AsString ) ) <> -1 then
                         begin
                              //Verificando se um dos campos admite nulo
                              //Verificando o 1º Campo
                              Query2.SQL.Text := ' select * from rdb$relation_fields, rdb$fields ' +
                                                 ' where RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE AND ' +
                                                 '       rdb$relation_fields.rdb$relation_name = ''' + Trim( Query_Join.FieldByName( 'TABELA_RELACIONADA' ).AsString ) + ''' AND rdb$relation_fields.RDB$FIELD_NAME = ''' + Trim( Query_Join.FieldByName( 'CAMPO_RELACIONADO' ).AsString ) + '''';
                              Query2.Open;

                              if ( Query2.FieldByName( 'RDB$NULL_FLAG' ).AsString = '' ) and
                                 ( Query2.FieldByName( 'RDB$NULL_FLAG1' ).AsString = '' ) then
                              begin
                                   //armazenando o tipo de ligação
                                   Inner_Ou_Left := 'LEFT JOIN';
                              end
                              else
                              begin
                                   //Verificando o 2º Campo
                                   Query2.SQL.Text := ' select * from rdb$relation_fields, rdb$fields ' +
                                                      ' where RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE AND ' +
                                                      '       rdb$relation_fields.rdb$relation_name = ''' + Trim( Query_Join.FieldByName( 'RDB$RELATION_NAME' ).AsString ) + ''' AND rdb$relation_fields.RDB$FIELD_NAME = ''' + Trim( Query_Join.FieldByName( 'CAMPO' ).AsString ) + '''';
                                   Query2.Open;

                                   if ( Query2.FieldByName( 'RDB$NULL_FLAG' ).AsString = '' ) and
                                      ( Query2.FieldByName( 'RDB$NULL_FLAG1' ).AsString = '' ) then
                                   begin
                                        Inner_Ou_Left := 'LEFT JOIN';
                                   end
                                   else
                                   begin
                                        if ( Inner_Ou_Left = '' ) then
                                        begin
                                             Inner_Ou_Left := 'INNER JOIN';
                                        end;
                                   end;
                              end;

                              Query2.Close;

                              //Se for o primeiro campo de uma chave composta então armazene na variável...
                              if ( Query_Join.FieldByName( 'RDB$FIELD_POSITION' ).AsInteger = 0 ) then
                              begin
                                   //é adicionado o nome "TABELA" para podermos adicionar mais tarde o nome da tabela
                                   //O caracter "|" é para marcar a posição da relação INNER ou LEFT
                                   Script_Temp := ' |TABELA ON ' + LstTabelas_Selecionadas.Items[i] + '.' + Trim( Query_Join.FieldByName( 'CAMPO_RELACIONADO' ).AsString  ) + ' = ' + Trim( Query_Join.FieldByName( 'RDB$RELATION_NAME' ).AsString ) + '.' + Trim( Query_Join.FieldByName( 'CAMPO' ).AsString );
                              end
                              else
                              //Se não for o primeiro campo de uma chave composta então adicione o resto do join...
                              begin
                                   Script_Temp := Script_Temp + ' AND ' + LstTabelas_Selecionadas.Items[i] + '.' + Trim( Query_Join.FieldByName( 'CAMPO_RELACIONADO' ).AsString  ) + ' = ' + Trim( Query_Join.FieldByName( 'RDB$RELATION_NAME' ).AsString ) + '.' + Trim( Query_Join.FieldByName( 'CAMPO' ).AsString );
                              end;

                              //Esta variável será adicionada na frente do JOIN indicando as tabelas que participam da
                              //ligação
                              Tabelas_Selecionadas := LstTabelas_Selecionadas.Items[i] + '/' + Trim( Query_Join.FieldByName( 'RDB$RELATION_NAME' ).AsString );
                         end;

                         Query_Join.Next;

                         //Se esta constraint já foi processada, então vou adicionar numa lista
                         if ( Constraint <> Query_Join.FieldByName( 'NOME_CONSTRAINT' ).AsString ) or Query_Join.eof then
                         begin
                              if Script_Temp <> '' then
                              begin
                                   //Substituindo | por INNER JOIN ou LEFT JOIN
                                   while Pos( '|', Script_Temp ) > 0 do
                                   begin
                                        Script_Temp := Copy( Script_Temp, 1, Pos( '|', Script_Temp ) -1 ) + Inner_Ou_Left + Copy( Script_Temp, Pos('|', Script_Temp) + 1, Length( Script_Temp ) );
                                   end;

                                   //Adicionando a ligação na lista. Primeiro coloco os caracteres de controle das tabelas e depois o JOIN propriamente dito
                                   Lista_Joins.Items.Add( Tabelas_Selecionadas + ':' + Script_Temp );

                                   Script_Temp := '';

                                   Inner_Ou_Left := '';
                              end;

                              //Atualizando no nome da constraint
                              Constraint := Query_Join.FieldByName( 'NOME_CONSTRAINT' ).AsString;
                         end;
                    end;

                    Query_Join.Close;
               end;

               Paragrafo := '';

               From_Used := False;

               //Criando o join
               For j := 0 to LstTabelas_Selecionadas.Count -2 do
               begin
                    //Inicializando variável de controle
                    Achou := False;

                    For i := 0 to Lista_Joins.Count -1 do
                    begin
                         //Inicialmente a relação é feita entre tabelas sequenciais. A 1º com a 2º, a 2º com a 3º ...
                         //Subentende-se que o usuário adicionou as tabelas de forma que a tabela dependente foi
                         //selecionada após a tabela principal
                         if ( Copy( Lista_Joins.Items[i], 1, Pos( ':', Lista_Joins.Items[i] ) -1 ) = LstTabelas_Selecionadas.Items[j] + '/' + LstTabelas_Selecionadas.Items[j + 1] ) or
                            ( Copy( Lista_Joins.Items[i], 1, Pos( ':', Lista_Joins.Items[i] ) -1 ) = LstTabelas_Selecionadas.Items[j + 1] + '/' + LstTabelas_Selecionadas.Items[j] ) then
                         begin
                              //O primeiro Join sempre vai ter o FROM desde que não haja duas constraints apontando para a mesma tabela
                              if ( J = 0 ) and not From_Used then
                              begin
                                   //Formatando o join, tirando os caracteres de controle
                                   Lista_Joins.Items[i] := Copy( Lista_Joins.Items[i], 1, Pos( 'TABELA', Lista_Joins.Items[i] ) -1 ) + ' ' + LstTabelas_Selecionadas.Items[j+1] + ' ' + Copy( Lista_Joins.Items[i], Pos( 'TABELA', Lista_Joins.Items[i] ) + 7, Length( Lista_Joins.Items[i] ) );
                                   Linha_Temp := 'FROM ' + LstTabelas_Selecionadas.Items[j] + Copy( Lista_Joins.Items[i], Pos( ':', Lista_Joins.Items[i] ) + 1, Length( Lista_Joins.Items[i] ) );

                                   From_Used := True;
                              end
                              else
                              begin
                                   //Formatando o join, tirando os caracteres de controle
                                   Lista_Joins.Items[i] := Copy( Lista_Joins.Items[i], 1, Pos( 'TABELA', Lista_Joins.Items[i] ) -1 ) + ' ' + LstTabelas_Selecionadas.Items[j+1] + ' ' + Copy( Lista_Joins.Items[i], Pos( 'TABELA', Lista_Joins.Items[i] ) + 7, Length( Lista_Joins.Items[i] ) );
                                   Linha_Temp := Copy( Lista_Joins.Items[i], Pos( ':', Lista_Joins.Items[i] ) + 2, Length( Lista_Joins.Items[i] ) );
                              end;

                              //Adicionando o nome das tabelas que já participaram, "dando oportunidade"
                              //para as outras tabelas serem mencionadas nos próximos joins
                              Lst_Temp.Add( LstTabelas_Selecionadas.Items[j] );
                              Lst_Temp.Add( LstTabelas_Selecionadas.Items[j+1] );

                              //Adicionando JOIN ao script com parágrafo
                              MemScript.Lines.Add( Paragrafo + Linha_Temp );

                              //Aumentando o parágrafo
                              Paragrafo := Paragrafo + '      ';

                              //Existe uma relação entre as tabelas sequencialmente
                              Achou := True;
                         end;
                    end;

                    //Não foi encontrada relação entre tabelas paralelas, então vamos varrer a lista de tabelas
                    //Até encontrar a tabela que está relacionada
                    if not Achou then
                    begin
                         For k := 0 to LstTabelas_Selecionadas.Count -1 do
                         begin
                              //Não pode ser a mesma tabela usada anteriormente
                              if k <> j + 1 then
                              begin
                                   For i := 0 to Lista_Joins.Count -1 do
                                   begin
                                        //Verifica se existe a relação
                                        if ( Copy( Lista_Joins.Items[i], 1, Pos( ':', Lista_Joins.Items[i] ) -1 ) = LstTabelas_Selecionadas.Items[j + 1] + '/' + LstTabelas_Selecionadas.Items[k] ) or
                                           ( Copy( Lista_Joins.Items[i], 1, Pos( ':', Lista_Joins.Items[i] ) -1 ) = LstTabelas_Selecionadas.Items[k] + '/' + LstTabelas_Selecionadas.Items[j + 1] ) then
                                        begin
                                             //Verifica se a tabela já foi adicionada em alguma relação
                                             if ( Lst_Temp.IndexOf( LstTabelas_Selecionadas.Items[j + 1] ) <> -1 ) or
                                                ( Lst_Temp.IndexOf( LstTabelas_Selecionadas.Items[k] ) <> -1 ) then
                                             begin
                                                  //Pegando o nome da tabela apropriada para o join
                                                  if Lst_Temp.IndexOf( LstTabelas_Selecionadas.Items[j + 1] ) = -1 then
                                                  begin
                                                       Tabela_Selecionada := LstTabelas_Selecionadas.Items[j + 1];
                                                  end
                                                  else
                                                  begin
                                                       Tabela_Selecionada := LstTabelas_Selecionadas.Items[k];
                                                  end;

                                                  //Formatando o join, tirando os caracteres de controle
                                                  Lista_Joins.Items[i] := Copy( Lista_Joins.Items[i], 1, Pos( 'TABELA', Lista_Joins.Items[i] ) -1 ) + ' ' + Tabela_Selecionada + ' ' + Copy( Lista_Joins.Items[i], Pos( 'TABELA', Lista_Joins.Items[i] ) + 7, Length( Lista_Joins.Items[i] ) );
                                                  Linha_Temp := Copy( Lista_Joins.Items[i], Pos( ':', Lista_Joins.Items[i] ) + 2, Length( Lista_Joins.Items[i] ) );

                                                  //adicionando JOIN ao script com parágrafo
                                                  MemScript.Lines.Add( Paragrafo + Linha_Temp );

                                                  //Aumentando o parágrafo
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

     //Selecionando o filtro "WHERE"
     For i := 0 to LstFiltro.Items.Count -1 do
     begin
          if Pos( 'Maior ou Igual', LstFiltro.Items[i] ) > 0 then
          begin
               Operacao := ' >= ';

               Prefixo := '';
               SulFixo := '';
          end
          else
          if Pos( 'Menor ou Igual', LstFiltro.Items[i] ) > 0 then
          begin
               Operacao := ' <= ';

               Prefixo := '';
               SulFixo := '';
          end
          else
          if Pos( 'Igual', LstFiltro.Items[i] ) > 0 then
          begin
               Operacao := ' = ';

               Prefixo := '';
               SulFixo := '';
          end
          else
          if Pos( 'Diferente', LstFiltro.Items[i] ) > 0 then
          begin
               Operacao := ' <> ';

               Prefixo := '';
               SulFixo := '';
          end
          else
          if ( Pos( 'Não Começando com', LstFiltro.Items[i] ) > 0 ) then
          begin
               Operacao := ' NOT LIKE ';

               Prefixo := '''';
               SulFixo := '%''';
          end
          else
          if ( Pos( 'Não Contendo', LstFiltro.Items[i] ) > 0 ) then
          begin
               Operacao := ' NOT LIKE ';

               Prefixo := '''%';
               SulFixo := '%''';
          end
          else
          if ( Pos( 'Começando com', LstFiltro.Items[i] ) > 0 ) then
          begin
               Operacao := ' LIKE ';

               Prefixo := '''';
               SulFixo := '%''';
          end
          else
          if ( Pos( 'Contendo', LstFiltro.Items[i] ) > 0 ) then
          begin
               Operacao := ' LIKE ';

               Prefixo := '''%';
               SulFixo := '%''';
          end;

          Where := Copy( LstFiltro.Items[i], 1, Pos( '"', LstFiltro.Items[i] ) -2 ) + Operacao + Prefixo + Copy( LstFiltro.Items[i], Pos( '[', LstFiltro.Items[i] ) + 1, Pos( ']', LstFiltro.Items[i] ) -1 - Pos( '[', LstFiltro.Items[i] ) ) + Sulfixo;

          if i <> LstFiltro.Count -1 then
          begin
               Where := Where + ' AND ';
          end;

          if i = 0 then
          begin
               MemScript.Lines.Add( 'WHERE ' + Where );
          end
          else
          begin
               MemScript.Lines.Add( '      ' + Where );
          end;
     end;

     //Selecionando o GROUP BY
     if LstCampos_Agregados.items.Count > 0 then
     begin
          For i := 0 to LstCampos_Selecionados.Items.Count -1 do
          begin
               if i = LstCampos_Selecionados.Items.Count -1 then
               begin
                    if i = 0 then
                    begin
                         MemScript.Lines.Add( 'GROUP BY ' + LstCampos_Selecionados.Items[i] );
                    end
                    else
                    begin
                         MemScript.Lines.Add( '      ' + LstCampos_Selecionados.Items[i] );
                    end;
               end
               else
               begin
                    if i = 0 then
                    begin
                          MemScript.Lines.Add( 'GROUP BY ' + LstCampos_Selecionados.Items[i] + ', ');
                    end
                    else
                    begin
                          MemScript.Lines.Add( '      ' + LstCampos_Selecionados.Items[i] + ', ');
                    end;
               end;
          end;
     end;

     //Selecionando o filtro "HAVING"
     For i := 0 to LstFiltro_Campos_Agregados.Items.Count -1 do
     begin
          if Pos( 'Maior ou Igual', LstFiltro_Campos_Agregados.Items[i] ) > 0 then
          begin
               Operacao := ' >= ';
          end
          else
          if Pos( 'Menor ou Igual', LstFiltro_Campos_Agregados.Items[i] ) > 0 then
          begin
               Operacao := ' <= ';
          end
          else
          if Pos( 'Igual', LstFiltro_Campos_Agregados.Items[i] ) > 0 then
          begin
               Operacao := ' = ';
          end
          else
          if Pos( 'Diferente', LstFiltro_Campos_Agregados.Items[i] ) > 0 then
          begin
               Operacao := ' <> ';
          end;

          Where := Copy( LstFiltro_Campos_Agregados.Items[i], 1, Pos( '"', LstFiltro_Campos_Agregados.Items[i] ) -2 ) + Operacao + Copy( LstFiltro_Campos_Agregados.Items[i], Pos( '[', LstFiltro_Campos_Agregados.Items[i] ) + 1, Pos( ']', LstFiltro_Campos_Agregados.Items[i] ) -1 - Pos( '[', LstFiltro_Campos_Agregados.Items[i] ) );

          if i = LstFiltro_Campos_Agregados.Items.Count -1 then
          begin
               if i = 0 then
               begin
                    MemScript.Lines.Add( 'HAVING ' + Where );
               end
               else
               begin
                    MemScript.Lines.Add( '       ' + Where );
               end;
          end
          else
          begin
               if i = 0 then
               begin
                    MemScript.Lines.Add( 'HAVING ' + Where + ' AND ');
               end
               else
               begin
                    MemScript.Lines.Add( '       ' + Where + ' AND ');
               end;
          end;
     end;

     //Selecionando ORDER BY. Sempre pelo índice do campo
     For i := 0 to LstOrdem.Items.Count -1 do
     begin
          //Se não for o último campo da lista devo adicionar um sulfixo com ',' 
          if i <> LstOrdem.Items.Count -1 then
          begin
               Sulfixo := ', ';
          end
          else
          begin
               Sulfixo := '';
          end;

          if i = 0 then
          begin
               if Pos( '[Crescente]', LstOrdem.Items[i] ) > 0 then
               begin                                   //acha_indice acha a posição da seleção do campo
                    MemScript.Lines.Add( 'ORDER BY ' + Acha_Indice( Copy( LstOrdem.Items[i], 1, Pos( '[Crescente]', LstOrdem.Items[i] ) -2 ) ) + Sulfixo );
               end
               else
               begin
                    MemScript.Lines.Add( 'ORDER BY ' + Acha_Indice( Copy( LstOrdem.Items[i], 1, Pos( '[Decrescente]', LstOrdem.Items[i] ) -2 ) ) + ' DESC' + Sulfixo );
               end;
          end
          else
          begin
               if Pos( '[Crescente]', LstOrdem.Items[i] ) > 0 then
               begin
                    MemScript.Lines.Add( '         ' + Acha_Indice( Copy( LstOrdem.Items[i], 1, Pos( '[Crescente]', LstOrdem.Items[i] ) -2 ) ) + Sulfixo );
               end
               else
               begin
                    MemScript.Lines.Add( '         ' + Acha_Indice( Copy( LstOrdem.Items[i], 1, Pos( '[Decrescente]', LstOrdem.Items[i] ) -2 ) ) + ' DESC' + Sulfixo );
               end;
          end;
     end;
end;

function TFrmGera_Sql.Eh_View : Boolean;
begin
     Result := False;

     if LstTabelas_Selecionadas.Count = 1 then
     begin
          Query.SQL.Text := 'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' + LstTabelas_Selecionadas.Items[0] + '''';
          Query.Open;

          Result := not Query.IsEmpty;

          Query.Close;
     end;
end;

function TFrmGera_Sql.Verifica_View : Boolean;
var i : integer;
begin
     Result := True;

     if LstTabelas_Selecionadas.Count > 0 then
     begin
          For i := 0 to LstTabelas_Selecionadas.Items.Count -1 do
          begin
               if LstTabelas_Selecionadas.Items[i] <> CmbTabelas.Items[CmbTabelas.ItemIndex] then
               begin
                    Query.SQL.Text := 'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' + LstTabelas_Selecionadas.Items[i] + '''';
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
               if LstTabelas_Selecionadas.Items.IndexOf( CmbTabelas.Items[CmbTabelas.ItemIndex] ) = -1 then
               begin
                    Query.SQL.Text := 'SELECT * FROM RDB$VIEW_RELATIONS WHERE RDB$VIEW_NAME = ''' + CmbTabelas.Items[CmbTabelas.ItemIndex] + '''';
                    Query.Open;

                    Result := Query.IsEmpty;

                    Query.Close;
               end;
          end;
     end;
end;

procedure TFrmGera_Sql.FormShow(Sender: TObject);
begin
  FDGUIxLoginDialog1.;

     FrmConecta.ShowModal;

     if FrmConecta.ModalResult = MrOk then
     begin
          Query.SQL.Text := 'SELECT * FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0';
          Query.Open;

          CmbTabelas.Clear;

          while not Query.Eof do
          begin
               CmbTabelas.Items.Add( Trim( Query.FieldByName( 'RDB$RELATION_NAME' ).AsString ) );

               Query.Next;
          end;

          Query.Close;

          CmbCondicao.ItemIndex := 0;
     end;

     PageControl1.ActivePageIndex := 0;
     PCCondicao_Ordem.ActivePageIndex := 0;
     GBCampos_Selecionados.ActivePageIndex := 0;

     CmbOrdem.ItemIndex := 0;
     CmbCondicao.ItemIndex := 0;
     CmbCondicao_Agregados.ItemIndex := 0;
     CmbFuncao.ItemIndex := 0;
end;

procedure TFrmGera_Sql.BtnAddClick(Sender: TObject);
var Funcao : String;
begin
     if LstCampos.ItemIndex <> -1 then
     begin
          if GBCampos_Selecionados.ActivePageIndex = 0 then
          begin
               if LstTabelas_Selecionadas.ItemIndex <> -1 then
               begin
                    if LstCampos_Selecionados.Items.IndexOf( LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[LstCampos.ItemIndex] ) = -1 then
                    begin
                         LstCampos_Selecionados.Items.Add( LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[LstCampos.ItemIndex] );
                    end;

                    if LstCampos.ItemIndex < LstCampos.Items.Count -1 then
                    begin
                         LstCampos.ItemIndex := LstCampos.ItemIndex + 1;
                         LstCampos.Selected[LstCampos.ItemIndex] := True;
                    end;
               end
               else
               begin
                    MessageDlg( 'Selecione a tabela', MtInformation, [mbok], 0 );
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
                    else
                    if CmbFuncao.Text = 'Máximo' then
                    begin
                         Funcao := 'MAX(';
                    end
                    else
                    if CmbFuncao.Text = 'Média' then
                    begin
                         Funcao := 'AVG(';
                    end
                    else
                    if CmbFuncao.Text = 'Mínimo' then
                    begin
                         Funcao := 'MIN(';
                    end
                    else
                    if CmbFuncao.Text = 'Soma' then
                    begin
                         Funcao := 'SUM(';
                    end;

                    if LstTabelas_Selecionadas.ItemIndex <> -1 then
                    begin
                         LstCampos_Agregados.Items.Add( Funcao + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[LstCampos.ItemIndex] + ')' );

                         if LstCampos_Agregados.ItemIndex < LstCampos_Agregados.Items.Count -1 then
                         begin
                              LstCampos_Agregados.ItemIndex := LstCampos_Agregados.ItemIndex + 1;
                              LstCampos_Agregados.Selected[LstCampos_Agregados.ItemIndex] := True;
                         end;
                    end
                    else
                    begin
                         MessageDlg( 'Selecione a tabela', MtInformation, [mbok], 0 );
                    end;
               end;
          end;
     end;

     PCCondicao_OrdemChange( PCCondicao_Ordem );
end;

procedure TFrmGera_Sql.BtnAddAllClick(Sender: TObject);
var I : Integer;
begin
     For i := 0 to LstCampos.Count -1 do
     begin
          if LstCampos_Selecionados.Items.IndexOf( LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[i] ) = -1 then
          begin
               LstCampos_Selecionados.Items.Add( LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + LstCampos.Items[i] );
          end;
     end;
end;

procedure TFrmGera_Sql.BtnRemClick(Sender: TObject);
begin
     if GBCampos_Selecionados.ActivePageIndex = 0 then
     begin
          if LstCampos_Selecionados.ItemIndex <> -1 then
          begin
               LstCampos_Selecionados.DeleteSelected;

               if LstCampos_Selecionados.Count > 0 then
               begin
                    LstCampos_Selecionados.ItemIndex := LstCampos_Selecionados.Items.Count -1;
                    LstCampos_Selecionados.Selected[LstCampos_Selecionados.ItemIndex] := True;
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
                    LstCampos_Agregados.ItemIndex := LstCampos_Agregados.Items.Count -1;
                    LstCampos_Agregados.Selected[LstCampos_Agregados.ItemIndex] := True;
               end;
          end;
     end;

     PCCondicao_OrdemChange( PCCondicao_Ordem );
end;

procedure TFrmGera_Sql.BtnRemAllClick(Sender: TObject);
begin
     if MessageDlg( 'Confirma a remoção de todas as tabelas?', MtConfirmation, [mbyes, mbno], 0 ) = MrYes then
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

          PCCondicao_OrdemChange( PCCondicao_Ordem );
     end;
end;

procedure TFrmGera_Sql.Button1Click(Sender: TObject);
var Condicao : String;
begin
     if PCCondicao_Ordem.ActivePageIndex in [0,1] then
     begin
          if LstCampos_Filtro.ItemIndex <> -1 then
          begin
               if InputQuery( 'Adicionar Condição', 'Valor:', Condicao ) then
               begin
                    if PCCondicao_Ordem.ActivePageIndex = 0 then
                    begin
                         LstFiltro.Items.Add( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] + ' "' + CmbCondicao.Items[CmbCondicao.ItemIndex] + '" [' + Condicao + ']' );
                    end
                    else
                    if PCCondicao_Ordem.ActivePageIndex = 1 then
                    begin
                         LstFiltro_Campos_Agregados.Items.Add( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] + ' "' + CmbCondicao_Agregados.Items[CmbCondicao_Agregados.ItemIndex] + '" [' + Condicao + ']' );
                    end;
               end;
          end
          else
          begin
               MessageDlg( 'Selecione um Campo para filtragem', MtInformation, [mbok], 0 );
          end;
     end
     else
     if PCCondicao_Ordem.ActivePageIndex = 2 then
     begin
          if LstCampos_Filtro.ItemIndex <> -1 then
          begin
               LstOrdem.Items.Add( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] + ' [' + CmbOrdem.Text + ']' );
          end
          else
          begin
               MessageDlg( 'Selecione um Campo para Ordenação', MtInformation, [mbok], 0 );
          end;
     end;
end;

procedure TFrmGera_Sql.Button2Click(Sender: TObject);
begin
     if PCCondicao_Ordem.ActivePageIndex = 0 then
     begin
          LstFiltro.DeleteSelected;
     end
     else
     if PCCondicao_Ordem.ActivePageIndex = 1 then
     begin
          LstFiltro_Campos_Agregados.DeleteSelected;
     end
     else
     if PCCondicao_Ordem.ActivePageIndex = 2 then
     begin
          LstOrdem.DeleteSelected;
     end;
end;

procedure TFrmGera_Sql.Button3Click(Sender: TObject);
begin
     if PCCondicao_Ordem.ActivePageIndex = 0 then
     begin
          if ( LstCampos_Filtro.ItemIndex <> -1 ) and ( CmbCondicao.ItemIndex < 4 ) then
          begin
               LstFiltro.Items.Add( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] + ' "' + CmbCondicao.Items[CmbCondicao.ItemIndex] + '" [:' + Copy( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex], Pos('.', LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] ) + 1, Length( LstCampos_Filtro.Items[LstCampos_Filtro.ItemIndex] ) ) + ']' );
          end;
     end;
end;

procedure TFrmGera_Sql.PageControl1Change(Sender: TObject);
var i : Integer;
    Parametro : String;
begin
     if PageControl1.ActivePageIndex = 1 then
     begin
          BtnGera_SqlClick( BtnGera_Sql );
          BtnPreparaClick( BtnPrepara );
          
          if Trim( MemScript.Text ) <> '' then
          begin
               if not eh_view then
               begin
                    if Pos( 'ORDER BY', MemScript.Text ) > 0 then
                    begin
                         Query_Relatorio.SQL.Text := Copy( MemScript.Text, 1, Pos( 'ORDER BY', MemScript.Text ) -1 ) + #13 + MemPlan.Text + #13 + Copy( MemScript.Text, Pos( 'ORDER BY', MemScript.Text ), Length( MemScript.Text ) );
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

               For i := 0 to Query_Relatorio.ParamCount -1 do
               begin
                    Parametro := '';

                    if InputQuery( 'Digite valor do Parâmetro', Query_Relatorio.Params[i].Name, Parametro ) then
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

procedure TFrmGera_Sql.LstCampos_AgregadosDblClick(Sender: TObject);
var Linha : String;
begin
     if LstCampos_Agregados.ItemIndex <> -1 then
     begin
          Linha := LstCampos_Agregados.Items[ LstCampos_Agregados.ItemIndex];

          if InputQuery( 'Alterar campo agregado', 'Campo Agregado', Linha ) then
          begin
               LstCampos_Agregados.Items[ LstCampos_Agregados.ItemIndex] := Linha;
          end;
     end;
end;

procedure TFrmGera_Sql.PCCondicao_OrdemChange(Sender: TObject);
var i : Integer;
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
               Query.SQL.Text := ' SELECT * FROM RDB$RELATION_FIELDS WHERE RDB$SYSTEM_FLAG = 0 AND RDB$RELATION_NAME = ''' + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + ''' ORDER BY RDB$FIELD_POSITION';
               Query.Open;

               while not Query.Eof do
               begin
                    LstCampos_Filtro.Items.Add( Trim( LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + '.' + Query.FieldByName( 'RDB$FIELD_NAME' ).AsString ) );

                    Query.Next;
               end;

               Query.Close;
          end;
     end
     else
     if PCCondicao_Ordem.ActivePageIndex = 1 then
     begin
          LstCampos_Filtro.Items := LstCampos_Agregados.Items;
     end
     else
     if PCCondicao_Ordem.ActivePageIndex = 2 then
     begin
          LstCampos_Filtro.Clear;

          for i := 0 to LstCampos_Selecionados.Items.Count -1 do
          begin
               LstCampos_Filtro.Items.Add( LstCampos_Selecionados.Items[i] );
          end;

          for i := 0 to LstCampos_Agregados.Items.Count -1 do
          begin
               LstCampos_Filtro.Items.Add( LstCampos_Agregados.Items[i] );
          end;
     end;
end;

procedure TFrmGera_Sql.LstFiltroDblClick(Sender: TObject);
var Linha : String;
begin
     if LstFiltro.ItemIndex <> -1 then
     begin
          Linha := LstFiltro.Items[ LstFiltro.ItemIndex];

          if InputQuery( 'Alterar Condição', 'Condição:', Linha ) then
          begin
               LstFiltro.Items[ LstFiltro.ItemIndex] := Linha;
          end;
     end;
end;

procedure TFrmGera_Sql.LstFiltro_Campos_AgregadosDblClick(Sender: TObject);
var Linha : String;
begin
     if LstFiltro_Campos_Agregados.ItemIndex <> -1 then
     begin
          Linha := LstFiltro_Campos_Agregados.Items[ LstFiltro_Campos_Agregados.ItemIndex];

          if InputQuery( 'Alterar condição campo agregado', 'Condição', Linha ) then
          begin
               LstFiltro_Campos_Agregados.Items[ LstFiltro_Campos_Agregados.ItemIndex] := Linha;
          end;
     end;
end;

procedure TFrmGera_Sql.ChkTodosClick(Sender: TObject);
begin
     if not ChkTodos.Checked then
     begin
          if EdtFirst.Text = '0' then
          begin
               UDFirst.Position := 10;
          end;
     end;
end;

procedure TFrmGera_Sql.LstTabelas_SelecionadasClick(Sender: TObject);
begin
     if LstTabelas_Selecionadas.ItemIndex <> -1 then
     begin
          Query.SQL.Text := ' SELECT * FROM RDB$RELATION_FIELDS WHERE RDB$SYSTEM_FLAG = 0 AND RDB$RELATION_NAME = ''' + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex] + ''' ORDER BY RDB$FIELD_POSITION';
          Query.Open;

          LstCampos.Clear;

          while not Query.Eof do
          begin
               LstCampos.Items.Add( Trim( Query.FieldByName( 'RDB$FIELD_NAME' ).AsString ) );

               Query.Next;
          end;

          Query.Close;

          LbCampos.Caption := 'Campos - ' + LstTabelas_Selecionadas.Items[LstTabelas_Selecionadas.ItemIndex];
     end
     else
     begin
          LbCampos.Caption := 'Campos';
     end;

     PCCondicao_OrdemChange( PCCondicao_Ordem );
end;

procedure TFrmGera_Sql.Button4Click(Sender: TObject);
begin
     if not Verifica_View then
     begin
          MessageDlg( 'Uma view só pode ser selecionada sozinha', MtInformation, [mbok], 0 );
          Exit;
     end;

     if LstTabelas_Selecionadas.Items.IndexOf( CmbTabelas.Items[CmbTabelas.ItemIndex] ) = -1 then
     begin
          LstTabelas_Selecionadas.Items.Add( CmbTabelas.Items[CmbTabelas.ItemIndex] );
     end;
end;

procedure TFrmGera_Sql.Button5Click(Sender: TObject);
begin
     LstTabelas_Selecionadas.DeleteSelected;

     if LstTabelas_Selecionadas.Items.Count = 0 then
     begin
          LbCampos.Caption := 'Campos';
     end;

     LstCampos.Clear;
end;

procedure TFrmGera_Sql.Query_JoinFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
     if ( LstTabelas_Selecionadas.ItemIndex <> -1 ) and ( Indice_Filtro <> -1 ) then
     begin
          Accept := ( LstTabelas_Selecionadas.Items[Indice_Filtro] = Trim( Query_Join.FieldByName( 'TABELA_RELACIONADA' ).AsString ) );
     end;
end;

procedure TFrmGera_Sql.Button6Click(Sender: TObject);
var Temp : String;
begin
     if ( LstTabelas_Selecionadas.ItemIndex > 0 ) then
     begin
          Temp := LstTabelas_Selecionadas.items[ LstTabelas_Selecionadas.ItemIndex ];
          LstTabelas_Selecionadas.items[ LstTabelas_Selecionadas.ItemIndex] := LstTabelas_Selecionadas.items[ LstTabelas_Selecionadas.ItemIndex - 1];
          LstTabelas_Selecionadas.items[ LstTabelas_Selecionadas.ItemIndex - 1] := Temp;

          LstTabelas_Selecionadas.ItemIndex := LstTabelas_Selecionadas.ItemIndex -1;

          LstTabelas_SelecionadasClick( LstTabelas_Selecionadas );
     end;
end;

procedure TFrmGera_Sql.BtnGera_SqlClick(Sender: TObject);
begin
     Gera_Script;
end;

procedure TFrmGera_Sql.BtnPreparaClick(Sender: TObject);
begin
     if Trim( MemScript.Text ) <> '' then
     begin
          IBSQL.SQL.Text := MemScript.Text;

          Try
               IBSQL.Prepare;
          except
                On E: Exception do
                begin
                     MemPlan.Clear;
                     MemPlan.Text := E.Message;
                end;
          end;

          if IBSQL.Prepared then
          begin
               MemPlan.lines.Text := IBSQL.Plan;
          end;
     end
     else
     begin
          MemPlan.lines.Clear;
     end;
end;

procedure TFrmGera_Sql.SpeedButton2Click(Sender: TObject);
begin
  Clipboard.AsText := MemScript.Text;
end;

end.
