USE cid10;

SELECT * 
	FROM cid10.cid_capitulo;
/*
	F00	F99	V - Transtornos mentais e comportamentais
	G00	G99	VI - Doenças do sistema nervoso
*/

SELECT * 
	FROM cid_categoria
    WHERE descricao like lower('%alzheimer%');
/*
	F00	Demência na doença de Alzheimer
	G30	Doença de Alzheimer
*/

SELECT * 
	FROM cid_grupo
    WHERE cat_inicio IN ('F00', 'G30');
/*
	F00	F09	Transtornos mentais orgânicos
	G30	G32	Outras doenças degenerativas do sistema nervoso
*/

SELECT * from cid_sub_categoria
	WHERE id like lower('%x%');

SELECT * FROM sim_data.Idade 
	WHERE Cod_Idade = 460;

SELECT * 
	FROM cid_sub_categoria
	WHERE descricao like lower('%alzheimer%');
/*
F000	Demência na doença de Alzheimer de início precoce
F001	Demência na doença de Alzheimer de início tardio
F002	Demência na doença de Alzheimer
F009	Demência não especificada na doença de Alzheimer
G300	Doença de Alzheimer de início precoce
G301	Doença de Alzheimer de início tardio
G308	Outras formas de doença de Alzheimer
G309	Doença de Alzheimer não especificada
*/

SELECT * 
	FROM cid10.cid_sub_categoria
    WHERE id = 'R54X';

SELECT * 
	FROM Idade
    WHERE Idade = "60 anos";

USE sim_data;


-- 2012
SELECT * 
	FROM Mortalidade_Geral_2012
	LIMIT 10;    

SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2012
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2012
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2012
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2012
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
        
/*
	LINHAB 	CID		QTD
	LINHAA	*G300	10
	LINHAA	*G301	39
	LINHAA	*G308	7
	LINHAA	*G309	1117
	LINHAB	*G309	2486
	LINHAB	*G301	55
	LINHAB	*G308	21
	LINHAB	*G300	17
	LINHAB	*F002	1
	LINHAC	*G309	3591
	LINHAC	*G300	23
	LINHAC	*G308	31
	LINHAC	*F000	1
	LINHAC	*G301	77
	LINHAC	*F009	1
	LINHAD	*G309	2561
	LINHAD	*G308	15
	LINHAD	*G300	17
	LINHAD	*G301	55
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2012');

SELECT * FROM Mortalidade_Geral_2012_filtrada LIMIT 10;

-- Problema com duplicado -> por conta do "or" na proc, se tem cid na linhaa OU linhab
SELECT COUNT(CONTADOR) FROM Mortalidade_Geral_2012_filtrada;
-- 13.084
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2012_filtrada;
-- 12.486

SELECT * 
	FROM Mortalidade_Geral_2012_analise 
	LIMIT 10;

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2012_analise');
SELECT * FROM Mortalidade_Geral_2012_analise_Previa;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 83 anos, 8.438 Feminino, 9.916 pessoas Brancas, 6577 Viuvos e 3918 Casados, escolaridade 1_3 4107, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2012_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;

-- Aposentado/Pensionista				4539
-- Dona de Casa							3324
-- Trabalhador agropecuário em geral	294
-- Trabalhador volante da agricultura	259
-- Comerciante varejista				182

-- CAUSA DIRETA DE MORTE PELA DOENÇA

SELECT COUNT(*)
	FROM Mortalidade_Geral_2012_analise
    WHERE causabas IN ('F000', 'F001', 'F002', 'F009', 'G300', 'G301', 'G308', 'G309');
-- 13.084

-- Mortalidade predominante por mulheres

-- FEMININO BRANCA ***************
SELECT COUNT(*) 
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Branca';
-- 6.524 dos casos de morte, eram mulheres brancas -> 49% dos casos de morte e 77% das mulheres que morreram 

SELECT CAUSABAS, CausaBas_Cid, COUNT(CAUSABAS) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Branca'
        GROUP BY CAUSABAS, CausaBas_Cid
        ORDER BY qtd DESC;

-- G309	Doença de Alzheimer não especificada	6240
-- G301	Doença de Alzheimer de início tardio	225
-- G300	Doença de Alzheimer de início precoce	36
-- G308	Outras formas de doença de Alzheimer	23

SELECT Profissao, COUNT(Profissao) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Branca'
        GROUP BY Profissao 
        ORDER BY qtd DESC;
        
-- Dona de Casa														2661
-- Aposentado/Pensionista											2019
-- Trabalhador agropecuário em geral								75
-- Trabalhador volante da agricultura								89
-- Empregado doméstico nos serviços gerais							63

SELECT EstadoCivil, COUNT(EstadoCivil) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Branca'
        GROUP BY EstadoCivil 
        ORDER BY qtd DESC;
        
-- Viúvo	4327
-- Casado	1032
-- Solteiro	644

-- FEMININO PARDA *** ***************
SELECT COUNT(*) 
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Parda';
-- 1182 dos casos de morte, eram mulheres pardas -> 9% dos casos de morte e 14% das mulheres que morreram

SELECT CAUSABAS, CausaBas_Cid, COUNT(CAUSABAS) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Parda'
        GROUP BY CAUSABAS, CausaBas_Cid
        ORDER BY qtd DESC;
-- G309	Doença de Alzheimer não especificada	1130
-- G301	Doença de Alzheimer de início tardio	41
-- G308	Outras formas de doença de Alzheimer	6
-- G300	Doença de Alzheimer de início precoce	5

SELECT Profissao, COUNT(Profissao) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Parda'
        GROUP BY Profissao 
        ORDER BY qtd DESC;

-- Dona de Casa	429
-- Aposentado/Pensionista	396
-- Trabalhador agropecuário em geral	32
-- Empregado doméstico nos serviços gerais	24
-- Trabalhador volante da agricultura	23

SELECT EstadoCivil, COUNT(EstadoCivil) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Parda'
        GROUP BY EstadoCivil 
        ORDER BY qtd DESC;
-- Viúvo	684
-- Casado	192
-- Solteiro	184

-- MASCULINO BRANCA ***************
SELECT COUNT(*) 
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Branca';
-- 3391 dos casos eram homens brancos -> 25% dos casos de morte e 73% dos homens que morreram

SELECT CAUSABAS, CAUSABAS_Cid, COUNT(CAUSABAS) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Branca'
        GROUP BY CAUSABAS, CAUSABAS_Cid
        ORDER BY qtd DESC;
-- G309	Doença de Alzheimer não especificada	3228
-- G301	Doença de Alzheimer de início tardio	129
-- G308	Outras formas de doença de Alzheimer	19
-- G300	Doença de Alzheimer de início precoce	15

SELECT Profissao, COUNT(Profissao) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Branca'
        GROUP BY Profissao 
        ORDER BY qtd DESC;
        
-- Aposentado/Pensionista	1396
-- Trabalhador agropecuário em geral	130
-- Comerciante varejista	117

SELECT EstadoCivil, COUNT(EstadoCivil) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Branca'
        GROUP BY EstadoCivil 
        ORDER BY qtd DESC;
        
-- Casado	1990
-- Viúvo	933

-- MASCULINO PARDA ***************
SELECT COUNT(*) 
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Parda';
-- 783 dos casos eram homens pardos 

SELECT CAUSABAS, CAUSABAS_Cid, COUNT(CAUSABAS) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Parda'
        GROUP BY CAUSABAS, CAUSABAS_Cid
        ORDER BY qtd DESC;
        
-- G309	Doença de Alzheimer não especificada	748
-- G301	Doença de Alzheimer de início tardio	28
-- G308	Outras formas de doença de Alzheimer	6
-- G300	Doença de Alzheimer de início precoce	1

SELECT Profissao, COUNT(Profissao) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Parda'
        GROUP BY Profissao 
        ORDER BY qtd DESC;
-- Aposentado/Pensionista	312
-- Trabalhador agropecuário em geral	45
-- Trabalhador volante da agricultura	33
-- Pedreiro	18

SELECT EstadoCivil, COUNT(EstadoCivil) qtd
	FROM Mortalidade_Geral_2012_analise
    WHERE Sexo = 'Masculino' AND
		RacaCor = 'Parda'
        GROUP BY EstadoCivil 
        ORDER BY qtd DESC;
-- Casado	423
-- Viúvo	187
-- Solteiro	83

-- 2013
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2013
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2013
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2013
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2013
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;

/* 
	linha	CID	   QTD
	LINHAA	*F009	1
	LINHAA	*G300	6
	LINHAA	*G301	41
	LINHAA	*G308	12
	LINHAA	*G309	1116
	LINHAB	*F001	1
	LINHAB	*F009	1
	LINHAB	*G300	13
	LINHAB	*G301	62
	LINHAB	*G308	20
	LINHAB	*G309	2768
	LINHAC	*F001	1
	LINHAC	*F009	1
	LINHAC	*G300	31
	LINHAC	*G301	55
	LINHAC	*G308	20
	LINHAC	*G309	3811
	LINHAD	*F001	1
	LINHAD	*G300	12
	LINHAD	*G301	54
	LINHAD	*G308	15
	LINHAD	*G309	2753
*/    

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2013');
SELECT * FROM Mortalidade_Geral_2013_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2013_filtrada;
-- 13.268

SELECT * FROM Mortalidade_Geral_2013_analise LIMIT 10;

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2013_analise');
SELECT * FROM Mortalidade_Geral_2013_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 83 anos, 8.987 Feminino, 10.303 pessoas Brancas, 7004 Viuvos e 3995 Casados, escolaridade 1_3 4300, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2013_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista				5006
-- Dona de Casa							3393
-- Trabalhador volante da agricultura	301
-- Trabalhador agropecuário em geral	287
-- Comerciante varejista				196

-- 2014
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2014
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2014
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2014
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2014
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
	
/*
	linha	CID		QTD
	LINHAA	*F001	1
	LINHAA	*F002	1
	LINHAA	*F009	1
	LINHAA	*G300	9
	LINHAA	*G301	38
	LINHAA	*G308	8
	LINHAA	*G309	1314
	LINHAB	*G301	52
	LINHAB	*G309	2869
	LINHAB	*G300	17
	LINHAB	*G308	23
	LINHAB	*F000	3
	LINHAB	*F001	2
	LINHAB	*F009	2
	LINHAB	*F002	2
	LINHAC	*G309	4314
	LINHAC	*G301	68
	LINHAC	*F009	2
	LINHAC	*G300	23
	LINHAC	*G308	25
	LINHAC	*F001	1
	LINHAD	*G309	3072
	LINHAD	*G300	16
	LINHAD	*G301	46
	LINHAD	*G308	22
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2014');
SELECT * FROM Mortalidade_Geral_2014_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2014_filtrada;
-- 14.843

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2014_analise');
SELECT * FROM Mortalidade_Geral_2014_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 10.154 Feminino, 11.657 pessoas Brancas, 7946 Viuvos e 4497 Casados, escolaridade 1_3 4936, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2014_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;

-- Aposentado/Pensionista	5872
-- Dona de Casa	3758
-- Trabalhador volante da agricultura	337
-- Trabalhador agropecuário em geral	275
-- Ignorada	209


-- 2015
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2015
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2015
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2015
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2015
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
/* 
	linha	CID		QTD
	LINHAA	*G300	7
	LINHAA	*G301	41
	LINHAA	*G308	10
	LINHAA	*G309	1246
	LINHAB	*G309	3037
	LINHAB	*G308	16
	LINHAB	*G301	69
	LINHAB	*G300	20
	LINHAB	*F001	1
	LINHAB	*F000	2
	LINHAB	*F009	5
	LINHAC	*G309	4171
	LINHAC	*G300	16
	LINHAC	*G301	86
	LINHAC	*G308	25
	LINHAC	*F001	2
	LINHAC	*F009	5
	LINHAD	*G309	2924
	LINHAD	*G301	59
	LINHAD	*G308	11
	LINHAD	*F001	1
	LINHAD	*F009	5
	LINHAD	*G300	7
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2015');
SELECT * FROM Mortalidade_Geral_2015_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2015_filtrada;
-- 14.216

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2015_analise');
SELECT * FROM Mortalidade_Geral_2015_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 9.983 Feminino, 11.090 pessoas Brancas, 7784 Viuvos e 4298 Casados, escolaridade 1_3 4761, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2015_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista	5921
-- Dona de Casa	3439
-- Trabalhador volante da agricultura	384
-- Trabalhador agropecuário em geral	340
-- Comerciante varejista	211

-- 2016
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2016
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2016
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2016
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2016
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;

/*
	linha	CID 	QTD
	LINHAA	*F001	1
	LINHAA	*F009	4
	LINHAA	*G300	17
	LINHAA	*G301	57
	LINHAA	*G308	14
	LINHAA	*G309	1398
	LINHAB	*F000	2
	LINHAB	*F001	3
	LINHAB	*F009	6
	LINHAB	*G300	30
	LINHAB	*G301	77
	LINHAB	*G308	47
	LINHAB	*G309	3443
	LINHAC	*F001	2
	LINHAC	*F009	8
	LINHAC	*G300	30
	LINHAC	*G301	111
	LINHAC	*G308	46
	LINHAC	*G309	4674
	LINHAD	*F000	1
	LINHAD	*F001	2
	LINHAD	*F009	3
	LINHAD	*G300	15
	LINHAD	*G301	73
	LINHAD	*G308	24
	LINHAD	*G309	3434
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2016');
SELECT * FROM Mortalidade_Geral_2016_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2016_filtrada;
-- 17.249

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2016_analise');
SELECT * FROM Mortalidade_Geral_2016_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 11782 Feminino, 13329 pessoas Brancas, 9274 Viuvos e 5298 Casados, escolaridade 1_3 5451, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2016_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista	7208
-- Dona de Casa	4133
-- Trabalhador volante da agricultura	472
-- Trabalhador agropecuário em geral	354
-- Ignorada	244


-- 2017
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2017
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2017
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2017
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2017
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
/*
	LINHA	CID		QTD
	LINHAA	*F001	1
	LINHAA	*F002	2
	LINHAA	*F009	4
	LINHAA	*G300	17
	LINHAA	*G301	60
	LINHAA	*G308	23
	LINHAA	*G309	1497
	LINHAB	*F000	1
	LINHAB	*F001	3
	LINHAB	*F009	13
	LINHAB	*G300	27
	LINHAB	*G301	109
	LINHAB	*G308	38
	LINHAB	*G309	3790
	LINHAC	*F000	3
	LINHAC	*F001	3
	LINHAC	*F002	2
	LINHAC	*F009	16
	LINHAC	*G300	34
	LINHAC	*G301	147
	LINHAC	*G308	50
	LINHAC	*G309	5068
	LINHAD	*F001	3
	LINHAD	*F002	1
	LINHAD	*F009	2
	LINHAD	*G300	10
	LINHAD	*G301	84
	LINHAD	*G308	28
	LINHAD	*G309	3570
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2017');
SELECT * FROM Mortalidade_Geral_2017_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2017_filtrada;
-- 18.450

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2017_analise');
SELECT * FROM Mortalidade_Geral_2017_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 12827 Feminino, 14311 pessoas Brancas, 10140 Viuvos e 5531 Casados, escolaridade 1_3 5565, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2017_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;

-- Aposentado/Pensionista	7682
-- Dona de Casa	4547
-- Trabalhador volante da agricultura	566
-- Trabalhador agropecuário em geral	532
-- Comerciante varejista	264  


-- 2018
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2018
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2018
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2018
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2018
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;

/*
	LINHA	CID		QTD
	LINHAA	*F001	2
	LINHAA	*F002	3
	LINHAA	*F009	6
	LINHAA	*G300	1
	LINHAA	*G301	79
	LINHAA	*G308	28
	LINHAA	*G309	1531
	LINHAB	*F000	1
	LINHAB	*F001	7
	LINHAB	*F002	3
	LINHAB	*F009	17
	LINHAB	*G300	11
	LINHAB	*G301	122
	LINHAB	*G308	47
	LINHAB	*G309	3983
	LINHAC	*F001	4
	LINHAC	*F002	1
	LINHAC	*F009	19
	LINHAC	*G300	15
	LINHAC	*G301	114
	LINHAC	*G308	79
	LINHAC	*G309	5397
	LINHAD	*F001	3
	LINHAD	*F009	10
	LINHAD	*G300	8
	LINHAD	*G301	116
	LINHAD	*G308	41
	LINHAD	*G309	3837
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2018');
SELECT * FROM Mortalidade_Geral_2018_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2018_filtrada;
-- 20.515

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2018_analise');
SELECT * FROM Mortalidade_Geral_2018_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 13265 Feminino, 14905 pessoas Brancas, 10462 Viuvos e 5806 Casados, escolaridade 1_3 5451, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2018_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista	7925
-- Dona de Casa	4592
-- Trabalhador volante da agricultura	646
-- Trabalhador agropecuário em geral	519
-- Comerciante varejista	307

-- 2019
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2019
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2019
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2019
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2019
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
/*
	LINHA	CID  	QTD
	LINHAA	*F009	2
	LINHAA	*G300	22
	LINHAA	*G301	95
	LINHAA	*G308	36
	LINHAA	*G309	1768
	LINHAB	*F000	1
	LINHAB	*F001	1
	LINHAB	*F009	1
	LINHAB	*G300	43
	LINHAB	*G301	170
	LINHAB	*G308	61
	LINHAB	*G309	4432
	LINHAC	*F000	1
	LINHAC	*F001	1
	LINHAC	*F002	1
	LINHAC	*F009	9
	LINHAC	*G300	41
	LINHAC	*G301	176
	LINHAC	*G308	87
	LINHAC	*G309	6041
	LINHAD	*F000	1
	LINHAD	*F001	1
	LINHAD	*F009	4
	LINHAD	*G300	38
	LINHAD	*G301	121
	LINHAD	*G308	49
	LINHAD	*G309	4108
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2019');
SELECT * FROM Mortalidade_Geral_2019_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2019_filtrada;
-- 23.055

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2019_analise');
SELECT * FROM Mortalidade_Geral_2019_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 14839 Feminino, 16584 pessoas Brancas, 11666 Viuvos e 6514 Casados, escolaridade 1_3 5878, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2019_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista	8778
-- Dona de Casa	5119
-- Trabalhador volante da agricultura	749
-- Trabalhador agropecuário em geral	673
-- Comerciante varejista	332

-- 2020
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2020
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2020
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2020
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2020
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
/*
	LINHA	CID	 	QTD
	LINHAA	*F001	4
	LINHAA	*F002	1
	LINHAA	*F009	3
	LINHAA	*G300	26
	LINHAA	*G301	143
	LINHAA	*G308	50
	LINHAA	*G309	2221
	LINHAB	*F000	2
	LINHAB	*F001	7
	LINHAB	*F002	1
	LINHAB	*F009	10
	LINHAB	*G300	43
	LINHAB	*G301	185
	LINHAB	*G308	82
	LINHAB	*G309	4815
	LINHAC	*F001	4
	LINHAC	*F002	3
	LINHAC	*F009	11
	LINHAC	*G300	38
	LINHAC	*G301	158
	LINHAC	*G308	59
	LINHAC	*G309	5688
	LINHAD	*F001	4
	LINHAD	*F002	1
	LINHAD	*F009	6
	LINHAD	*G300	32
	LINHAD	*G301	154
	LINHAD	*G308	50
	LINHAD	*G309	3826
*/

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2020');
SELECT * FROM Mortalidade_Geral_2020_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2020_filtrada;
-- 23.109

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2020_analise');
SELECT * FROM Mortalidade_Geral_2020_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 14869 Feminino, 16033 pessoas Brancas, 11524 Viuvos e 6366 Casados, escolaridade 1_3 5640, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2020_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;

-- Aposentado/Pensionista	8846
-- Dona de Casa	4951
-- Trabalhador volante da agricultura	791
-- Trabalhador agropecuário em geral	657
-- Comerciante varejista	309

-- 2021
SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2021
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2021
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2021
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2021
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
        
/* 
	LINHA	CID		QTD
	LINHAA	*F000	1
	LINHAA	*F001	2
	LINHAA	*F002	3
	LINHAA	*F009	9
	LINHAA	*G300	20
	LINHAA	*G301	134
	LINHAA	*G308	43
	LINHAA	*G309	1924
	LINHAB	*F000	2
	LINHAB	*F001	4
	LINHAB	*F002	2
	LINHAB	*F009	10
	LINHAB	*G300	44
	LINHAB	*G301	159
	LINHAB	*G308	44
	LINHAB	*G309	4199
	LINHAC	*F000	4
	LINHAC	*F001	3
	LINHAC	*F002	3
	LINHAC	*F009	15
	LINHAC	*G300	34
	LINHAC	*G301	159
	LINHAC	*G308	67
	LINHAC	*G309	4715
	LINHAD	*F000	1
	LINHAD	*F002	2
	LINHAD	*F009	7
	LINHAD	*G300	28
	LINHAD	*G301	142
	LINHAD	*G308	52
	LINHAD	*G309	3450
*/    

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2021');
SELECT * FROM Mortalidade_Geral_2021_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2021_filtrada;
-- 20127

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2021_analise');
SELECT * FROM Mortalidade_Geral_2021_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 84 anos, 13087 Feminino, 13604 pessoas Brancas, 9849 Viuvos e 5366 Casados, escolaridade 1_3 5041, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2021_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;
    
-- Aposentado/Pensionista	7328
-- Dona de Casa	4052
-- Trabalhador volante da agricultura	841
-- Trabalhador agropecuário em geral	651
-- Caseiro (agricultura)	328

SELECT linha, CID, COUNT(*)qtd_casos
	FROM( 
			SELECT 'LINHAA' as linha,
			LINHAA as CID
			FROM Mortalidade_Geral_2022
		UNION ALL
			SELECT 'LINHAB' as linha,
			LINHAB as CID
            FROM Mortalidade_Geral_2022
		UNION ALL
			SELECT 'LINHAC' as linha,
			LINHAC as CID
            FROM Mortalidade_Geral_2022
		UNION ALL
			SELECT 'LINHAD' as linha,
			LINHAD as CID
            FROM Mortalidade_Geral_2022
                ) AS Subconsulta
		WHERE CID IN ('*F000', '*F001', '*F002', '*F009', '*G300', '*G301', '*G308', '*G309')
		GROUP BY linha, CID;
/*
	LINHA	CID	 	QTD
	LINHAA	*F001	3
	LINHAA	*F002	1
	LINHAA	*F009	5
	LINHAA	*G300	23
	LINHAA	*G301	137
	LINHAA	*G308	48
	LINHAA	*G309	2712
	LINHAB	*F000	3
	LINHAB	*F001	5
	LINHAB	*F002	4
	LINHAB	*F009	12
	LINHAB	*G300	32
	LINHAB	*G301	180
	LINHAB	*G308	74
	LINHAB	*G309	5552
	LINHAC	*F000	2
	LINHAC	*F001	1
	LINHAC	*F002	1
	LINHAC	*F009	15
	LINHAC	*G300	49
	LINHAC	*G301	208
	LINHAC	*G308	71
	LINHAC	*G309	6522
	LINHAD	*F000	1
	LINHAD	*F001	4
	LINHAD	*F002	1
	LINHAD	*F009	6
	LINHAD	*G300	25
	LINHAD	*G301	168
	LINHAD	*G308	42
	LINHAD	*G309	4534
*/

select * from sim_data.Mortalidade_Geral_2022 LIMIT 10;

CALL sim_data.SPR_Enriquece_Analise('Mortalidade_Geral_2022');
SELECT * FROM Mortalidade_Geral_2022_analise LIMIT 10; 
SELECT * FROM sim_data.Mortalidade_Geral_2022_filtrada LIMIT 10;
SELECT COUNT(distinct CONTADOR) FROM Mortalidade_Geral_2022_filtrada;
-- 28804

CALL sim_data.SPR_Analise_Exploratoria('Mortalidade_Geral_2022_analise');
SELECT * FROM Mortalidade_Geral_2022_analise_Previa LIMIT 10;
-- + Ocorrencias na linhaC e menos na linha A, Idade média de 85 anos, 18982 Feminino, 20305 pessoas Brancas, 14593 Viuvos e 7524 Casados, escolaridade 1_3 6894, maioria com assistencia med

SELECT Profissao, Count(Profissao) as qntd
	FROM Mortalidade_Geral_2022_analise
    GROUP BY Profissao
    ORDER BY qntd desc
	LIMIT 5;

-- Aposentado/Pensionista	10946
-- Dona de Casa	5946
-- Trabalhador volante da agricultura	1008
-- Trabalhador agropecuário em geral	869
-- Ignorada	434


-- Análise prévia: Predomina-se a mortalidade de Mulheres, etnias brancas, escolaridade de 1 - 3 anos e aposentados.

SELECT * 
	FROM Mortalidade_Geral_2022_analise
    WHERE Sexo = 'Feminino' AND
		RacaCor = 'Branca';
    
use sim_data;

-- drop table tb_alvo;
    
-- Criando a tabela que será exportada para utilizar no ambiente Jupyter
CREATE TABLE tb_alvo as 
	SELECT *, 2012 as ANO FROM Mortalidade_Geral_2012_filtrada
		UNION ALL
	SELECT *, 2013 AS ANO FROM Mortalidade_Geral_2013_filtrada
		UNION ALL
	SELECT *, 2014 AS ANO FROM Mortalidade_Geral_2014_filtrada
		UNION ALL
	SELECT *, 2015 AS ANO FROM Mortalidade_Geral_2015_filtrada
		UNION ALL
	SELECT *, 2016 AS ANO FROM Mortalidade_Geral_2016_filtrada
		UNION ALL
	SELECT *, 2017 AS ANO FROM Mortalidade_Geral_2017_filtrada
		UNION ALL
	SELECT *, 2018 AS ANO FROM Mortalidade_Geral_2018_filtrada
		UNION ALL
	SELECT *, 2019 AS ANO FROM Mortalidade_Geral_2019_filtrada
		UNION ALL
	SELECT *, 2020 AS ANO FROM Mortalidade_Geral_2020_filtrada
		UNION ALL
	SELECT *, 2021 AS ANO FROM Mortalidade_Geral_2021_filtrada
		UNION ALL
	SELECT *, 2022 AS ANO FROM Mortalidade_Geral_2022_filtrada;
    
select count(*) from tb_alvo;
-- 211.593
                
CALL sim_data.SPR_Enriquece_Analise('tb_alvo');
-- tb_alvo_analise tb_alvo_filtrada
CALL sim_data.SPR_Analise_Exploratoria('tb_alvo_analise');

select * from tb_alvo_analise_Previa; 
-- 19.105 LINHAA, 137.213 mulheres VS 74.359 homens, 152.037 brancos, 42.343 pardos, 106.819 viuvos e 59.113 casados, 58.024 esc 1_3 e 38.721 nenhuma esc e 40.772 esc 4_7

SELECT Sexo, COUNT(*)qtd
	FROM tb_alvo_analise
    WHERE RacaCor = 'Branca'
    GROUP BY Sexo
    ORDER BY Sexo;

SELECT Sexo, CAUSABAS, count(Sexo)qtd 
	FROM tb_alvo_analise
    WHERE CAUSABAS IN ('F000', 'F001', 'F002', 'F009', 'G300', 'G301', 'G308', 'G309')
    GROUP BY Sexo, CAUSABAS
    ORDER BY CAUSABAS;

-- Feminino				F009	1
-- Masculino			F009	1
-- Masculino			G300	324
-- Feminino				G300	491
-- Masculino			G301	2740
-- Feminino				G301	5547
-- Nao_Identificado		G301	1
-- Feminino				G308	1114
-- Masculino			G308	699
-- Feminino				G309	130060
-- Masculino			G309	70595
-- Nao_Identificado		G309	20

SELECT Profissao, count(Profissao)qtd 
	FROM tb_alvo_analise
    WHERE CAUSABAS IN ('F000', 'F001', 'F002', 'F009', 'G300', 'G301', 'G308', 'G309')
    GROUP BY Profissao
    ORDER BY qtd DESC;
    
-- Aposentado/Pensionista				80051
-- Dona de Casa							47254
-- Trabalhador volante da agricultura	6354
-- Trabalhador agropecuário em geral	5451
-- Comerciante varejista				2821

SELECT Locais, count(Locais)qtd 
	FROM tb_alvo_analise
    WHERE CAUSABAS IN ('F000', 'F001', 'F002', 'F009', 'G300', 'G301', 'G308', 'G309')
    GROUP BY Locais
    ORDER BY qtd DESC;
    
-- São Paulo			34249
-- Minas Gerais			29471
-- Rio Grande do Sul	20068
-- Rio de Janeiro		11254
-- Bahia				10634
-- Ceará				9639

SELECT * FROM tb_alvo_analise LIMIT 10;
    
select causabas, causabas_cid from tb_alvo_analise group by causabas,causabas_cid;