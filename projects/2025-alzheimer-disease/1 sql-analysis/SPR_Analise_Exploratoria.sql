-- DROP PROCEDURE sim_data.SPR_Analise_Exploratoria;

DELIMITER $$
CREATE PROCEDURE sim_data.SPR_Analise_Exploratoria(IN tabela VARCHAR(100))
BEGIN 

    DECLARE nomeTabelaFinal VARCHAR(100);
	DECLARE CIDs VARCHAR(100);
    
    SET nomeTabelaFinal := CONCAT(tabela, '_Previa');
	SET CIDs := '''F000'', ''F001'', ''F002'', ''F009'', ''G300'', ''G301'', ''G308'', ''G309''';
    
    
	-- Dropar as tabelas se já existir
    SET @cleanQueryTemp = CONCAT('DROP TABLE IF EXISTS ', nomeTabelaFinal, ';');
    PREPARE clear FROM @cleanQueryTemp;
	EXECUTE clear;
	DEALLOCATE PREPARE clear;
    
    SET @query1 = CONCAT(
		'CREATE TABLE IF NOT EXISTS ', nomeTabelaFinal, ' AS
			 SELECT 
			(SELECT COUNT(LINHAA) FROM ', tabela, ' WHERE REPLACE(LINHAA, ''*'','''') IN (', CIDs, ')) AS Ocorrencias_Alzheimer_LinhaA,
			(SELECT COUNT(LINHAB) FROM ', tabela, ' WHERE REPLACE(LINHAB, ''*'','''') IN (', CIDs, ')) AS Ocorrencias_Alzheimer_LinhaB,
			(SELECT COUNT(LINHAC) FROM ', tabela, ' WHERE REPLACE(LINHAC, ''*'','''') IN (', CIDs, ')) AS Ocorrencias_Alzheimer_LinhaC,
			(SELECT COUNT(LINHAD) FROM ', tabela, ' WHERE REPLACE(LINHAD, ''*'','''') IN (', CIDs, ')) AS Ocorrencias_Alzheimer_LinhaD,

			(SELECT AVG(CAST(REPLACE(Idade, ''anos'', '''')as UNSIGNED)) FROM ', tabela, ') AS Media_Idade,
			(SELECT MAX(CAST(REPLACE(Idade, ''anos'', '''')as UNSIGNED)) FROM ', tabela, ') AS Maior_Idade,
			(SELECT MIN(CAST(REPLACE(Idade, ''anos'', '''')as UNSIGNED)) FROM ', tabela, ') AS Menor_Idade,
            (SELECT COUNT(SEXO) FROM ', tabela, ' WHERE SEXO = ''Feminino'') AS Feminino,
            (SELECT COUNT(SEXO) FROM ', tabela, ' WHERE SEXO = ''Masculino'') AS Masculino,
			(SELECT COUNT(SEXO) FROM ', tabela, ' WHERE SEXO = ''Nao_Identificado'') AS Nao_Identificado,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Branca'') AS Raca_Branca,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Preta'') AS Raca_Preta,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Amarela'') AS Raca_Amarela,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Parda'') AS Raca_Parda,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Indígena'') AS Raca_Indigena,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE RacaCor = ''Não Identificado'') AS Raca_NI,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''Solteiro'') AS Solteiro,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''Casado'') AS Casado,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''Viúvo'') AS Viúvo,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''Separado/Divorciado'') AS Separado,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''União Estável'') AS Uniao_Estavel,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE EstadoCivil = ''Ignorado'') AS Ignorado,
            (SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''Nenhuma'') AS Nenhuma_Esc,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''De 1 a 3 anos'') AS Esc_1_3,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''De 4 a 7 anos'') AS Esc_4_7,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''8 a 11 anos'') AS Esc_8_11,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''12 anos e mais'') AS Esc_12_mais,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE Escolaridade = ''Ignorado_Escolaridade'') AS Esc_Ig,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE AssistenciaMedica = ''Sim'') AS Sim_AssistenciaMedica,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE AssistenciaMedica = ''Não'') AS Nao_AssistenciaMedica,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE AssistenciaMedica = ''Ignorado'') AS Ignorado_AssistenciaMedica,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE HouveNecropsia = ''Sim'') AS Sim_Necropsia,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE HouveNecropsia = ''Não'') AS Nao_Necropsia,
			(SELECT COUNT(*) FROM ', tabela, ' WHERE HouveNecropsia = ''Ignorado'') AS Ignorado_Necropsia
            ;'
    );
    
	PREPARE stmt FROM @query1;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
	SELECT CONCAT(nomeTabelaFinal);
    
END $$
DELIMITER ;