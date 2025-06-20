use sim_data;

SELECT COUNT(*) AS total_colunas
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'sim_data'
  AND TABLE_NAME = 'dados_selecionados_Geral';

  
CREATE TABLE dados_selecionados AS
SELECT *,
  TIMESTAMPDIFF(YEAR, STR_TO_DATE(dtnasc, '%d%m%Y'), STR_TO_DATE(dtobito, '%d%m%Y')) AS idade_calculada
FROM Mortalidade_Geral_2012
WHERE sexo = 2
  AND TIMESTAMPDIFF(YEAR, STR_TO_DATE(dtnasc, '%d%m%Y'), STR_TO_DATE(dtobito, '%d%m%Y')) BETWEEN 18 AND 40
  AND linhaa IN (
    '*I210', '*I211', '*I212', '*I213', '*I214', '*I219',
    '*I220', '*I221', '*I228', '*I229', '*I252'
  );


SELECT *
FROM Mortalidade_Geral_2014
WHERE sexo = 2
  AND dtnasc != ''
  AND dtobito != ''
  AND TIMESTAMPDIFF(YEAR, STR_TO_DATE(dtnasc, '%d%m%Y'), STR_TO_DATE(dtobito, '%d%m%Y')) BETWEEN 18 AND 40
  AND linhaa IN (
    '*I210', '*I211', '*I212', '*I213', '*I214', '*I219',
    '*I220', '*I221', '*I228', '*I229', '*I252'
  );

  
CREATE TABLE dados_selecionados_Geral AS
SELECT *
FROM Mortalidade_Geral_2012
WHERE sexo = 2
  AND dtnasc != ''
  AND dtobito != ''
  AND CHAR_LENGTH(dtnasc) = 8
  AND CHAR_LENGTH(dtobito) = 8
  AND TIMESTAMPDIFF(YEAR, STR_TO_DATE(dtnasc, '%d%m%Y'), STR_TO_DATE(dtobito, '%d%m%Y')) BETWEEN 18 AND 40
  AND linhaa IN (
    '*I210', '*I211', '*I212', '*I213', '*I214', '*I219',
    '*I220', '*I221', '*I228', '*I229', '*I252'
  );
  
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('Mortalidade_Geral_2012', 'Mortalidade_Geral_2013', 'Mortalidade_Geral_2014', 'Mortalidade_Geral_2015', 'Mortalidade_Geral_2016', 'Mortalidade_Geral_2017', 'Mortalidade_Geral_2018', 'Mortalidade_Geral_2019', 'Mortalidade_Geral_2020', 'Mortalidade_Geral_2021', 'Mortalidade_Geral_2022')
GROUP BY COLUMN_NAME
HAVING COUNT(DISTINCT TABLE_NAME) = 11;
  
  
insert into dados_selecionados_Geral
SELECT
ACIDTRAB, ASSISTMED, ATESTANTE, CAUSABAS, CAUSABAS_O, CAUSAMAT, CIRCOBITO, 
CIRURGIA, CODESTAB, CODMUNOCOR, CODMUNRES, COMUNSVOIM, CONTADOR, DIFDATA, DTATESTADO, 
DTCADASTRO, DTCADINF, DTCADINV, DTCONCASO, DTCONINV, DTINVESTIG, DTNASC, DTOBITO, DTRECEBIM, 
ESC, ESC2010, ESCMAE, ESCMAE2010, ESTCIV, EXAME, FONTE, FONTEINV, GESTACAO, GRAVIDEZ, 
HORAOBITO, IDADE, IDADEMAE, LINHAA, LINHAB, LINHAC, LINHAD, LINHAII, LOCOCOR, MORTEPARTO, 
NATURAL0, NECROPSIA, NUDIASOBIN, OBITOGRAV, OBITOPARTO, OBITOPUERP, OCUP, OCUPMAE, ORIGEM, 
PARTO, PESO, QTDFILMORT, QTDFILVIVO, RACACOR, SEMAGESTAC, SERIESCFAL, SERIESCMAE, SEXO, 
STDOEPIDEM, STDONOVA, TIPOBITO, TPMORTEOCO, TPOBITOCOR, TPPOS
FROM Mortalidade_Geral_2022
WHERE sexo = 2
AND dtnasc != ''
AND dtobito != ''
AND CHAR_LENGTH(dtnasc) = 8
AND CHAR_LENGTH(dtobito) = 8
AND TIMESTAMPDIFF(YEAR, STR_TO_DATE(dtnasc, '%d%m%Y'), STR_TO_DATE(dtobito, '%d%m%Y')) 
BETWEEN 18 AND 40
AND causabas IN (
'I210', 'I211', 'I212', 'I213', 'I214', 'I219',
'I220', 'I221', 'I228', 'I229', 'I252'
);

use sim_data;
  
select count(*) from dados_selecionados_Geral;














  
  
  
