# GerarSQL

Gerador de comandos SELECT para bancos de dados Firebird.

Escolha as tabelas, os campos (normais ou agregados), os filtros e a ordenação, e o programa monta
o SQL, incluindo os JOINs, que são deduzidos das chaves estrangeiras do banco. A aba de resultado
executa o comando e mostra os dados.

![image](https://github.com/user-attachments/assets/7987fe11-ef1d-4d14-aa64-2fd6bc6cbf54)

## Recursos

- **JOINs automáticos** pelas chaves estrangeiras entre as tabelas selecionadas, inclusive chaves
  compostas. A primeira tabela da lista vai para o `FROM`; as demais são ligadas a uma tabela já
  adicionada, na ordem em que foram selecionadas.
- **INNER ou LEFT JOIN**: se algum campo da ligação aceita nulo (no campo ou no domínio), a ligação
  é `LEFT JOIN`; caso contrário, `INNER JOIN`.
- **Mesma tabela mais de uma vez**: quando mais de um campo referencia a mesma tabela (ex.:
  `VENDA.CLIENTE_ID` e `VENDA.VENDEDOR_ID` apontando para `PESSOA`), adicione a tabela de novo; ela
  recebe um apelido (`PESSOA_2`) e cada ocorrência usa uma chave estrangeira diferente:

  ```sql
  FROM VENDA
        INNER JOIN PESSOA ON PESSOA.ID = VENDA.CLIENTE_ID /* FK_VENDA_CLIENTE */
              LEFT JOIN PESSOA PESSOA_2 ON PESSOA_2.ID = VENDA.VENDEDOR_ID /* FK_VENDA_VENDEDOR */
  ```

  As chaves são distribuídas pela ordem alfabética do nome da constraint, e o comentário mostra qual
  foi usada. O mesmo vale para auto-relacionamento (ex.: `FUNCIONARIO.SUPERVISOR_ID`).
- **SQL compatível com a versão do banco**: ao conectar, o programa identifica em qual versão do
  Firebird o banco foi criado (pela ODS) e mostra no topo da tela. A sintaxe gerada segue essa versão:

  | Banco criado em | Limitar registros | Tabela sem chave estrangeira |
  |---|---|---|
  | Firebird 1.0 / 1.5 | `SELECT FIRST n` | `INNER JOIN T ON 1 = 1` |
  | Firebird 2.0 a 2.5 | `ROWS n` | `CROSS JOIN T` |
  | Firebird 3, 4 e 5 | `FETCH FIRST n ROWS ONLY` | `CROSS JOIN T` |

- Filtros (`WHERE`), filtros de agregados (`HAVING`), `GROUP BY` automático, ordenação e parâmetros.
- Cadastro de várias conexões, salvas em `Connection.xml` ao lado do executável.

## Requisitos

- Delphi 12 ou superior (testado no RAD Studio 13 / BDS 37.0), plataforma Win32, com FireDAC.
- [CodeSite](https://raize.com/codesite/) (unit `CodeSiteLogging`), usado para o log em `Log\`.
- Cliente do Firebird (`fbclient.dll`) compatível com o servidor.

Testado com Firebird 5. As consultas de metadados usam apenas recursos disponíveis desde o
Firebird 1.0.

## Limitações

- O botão **Preparar** (exibir o PLAN da consulta) está desativado.
- Nomes de tabelas e campos criados entre aspas (com minúsculas ou espaços) não são suportados.
- Não é possível escolher qual chave estrangeira cada ocorrência de uma tabela repetida usa.
