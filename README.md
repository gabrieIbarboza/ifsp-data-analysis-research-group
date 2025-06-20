# IFSP Data Analysis Research Group

Boas-vindas ao repositório do grupo de pesquisa em análise de dados do IFSP GRU!

## Sobre o Repositório
Este repositório é dedicado a um grupo de pesquisa do Instituto Federal de São Paulo (IFSP) que realiza a análise de dados de saúde pública do Brasil utilizando dados do SIM/DATASUS. O objetivo é fornecer um ambiente de pesquisa reprodutível para futuros pesquisadores, com instruções claras sobre como realizar o processo de ETL (Extração, Transformação e Carga), como executar as análises de dados, quais conhecimentos foram encontrados e quais os próximos passos que podem ser tomados.

## Estrutura de Pastas
O repositório está organizado da seguinte forma:

- **etl/**: Contém todos os scripts e arquivos necessários para o processo de ETL.
  - **csvtosql/**: Conversores de CSV para SQL.
  - **data-information/**: Documentação sobre os dados e o banco de dados.
  - `CID10.sql`: Script para criar e popular a tabela CID10, utilizada para enriquecer os dados.
  - `extract.sh` e `extract2.sh`: Scripts para automatizar o processo de ETL.
- **projects/**: Contém os projetos de análise de dados. Cada projeto é dividido em três partes:
  - `1 sql-analysis/`: Scripts SQL para análise exploratória e enriquecimento dos dados.
  - `2 python-analysis/`: Notebooks Jupyter com a análise de dados em Python com foco na mineração de dados.
  - `3 technical-report.pdf`: Relatório técnico com os resultados da análise.

## Como Usar

### Pré-requisitos
Antes de começar, certifique-se de ter instalado e configurado:
- Banco de dados SQL
- Python 3 com as seguintes bibliotecas:
  - pandas
  - numpy
  - seaborn
  - matplotlib
  - minisom

Após o processo de ETL, os dados estarão prontos para análise. Cada pasta de projeto (`/projects/2025-alzheimer-disease` e `/projects/2025-heart-attack-young-women`) contém um notebook Jupyter com a análise detalhada e dados filtrados para o escopo específico de cada doença.

- Para a análise da doença de Alzheimer, utilize o notebook `alzheimer-notebook.ipynb` na pasta `/projects/2025-alzheimer-disease/2 python-analysis/`.
- Para a análise de ataques cardíacos em mulheres jovens, utilize o notebook `heart-attack-notebook.ipynb` na pasta `/projects/2025-heart-attack-young-women/2 python-analysis/`.

## Projetos

### Análise de Óbitos por Alzheimer no Brasil (2012–2022)
Este projeto utilizou Mapas Auto-Organizáveis (SOMs) para identificar e visualizar padrões de comorbidades em 211.658 óbitos por Alzheimer no Brasil. A análise revelou três clusters distintos: um dominado pela própria DA, outro com causas mal definidas (R99X, R98X) e um terceiro associado a comorbidades cardiovasculares (I10X) e úlceras de decúbito (L89X). A metodologia aplicada seguiu boas práticas de reprodutibilidade e transparência, reforçando o valor dos SOMs na análise de dados secundários em saúde pública.

### Análise de Ataques Cardíacos em Mulheres Jovens
Este projeto analisa dados do SIM/DATASUS para identificar padrões em ataques cardíacos em mulheres jovens, também utilizando Mapas Auto-Organizáveis (SOM).

### Próximos passos para o grupo de pesquisa:
- Validação dos clusters por meio de prontuários eletrônicos;
- Análise de variações regionais e sociodemográficas nos padrões identificados;
- Comparação entre SOMs e outros algoritmos de clusterização;
- Análise temporal dos padrões ao longo de 2012–2022, incluindo efeitos da COVID-19;
- Desenvolvimento de modelos preditivos com base nos clusters identificados;
- Aperfeiçoamento contínuo da documentação e padronização do pipeline analítico.

## Dados
Os dados utilizados neste repositório são provenientes do Sistema de Informações sobre Mortalidade (SIM), disponibilizados pelo DATASUS. Para uma descrição detalhada das colunas do dataset, consulte o arquivo `dataset_columns_description.xlsx` na pasta `/etl/data-information/`.

## Contribuição
- Siga o padrão de organização das pastas.
- Documente bem seus scripts e análises.
- Para dúvidas, consulte os arquivos de documentação ou entre em contato com o responsável pelo grupo.

## Contato
Dúvidas ou sugestões? Entre em contato com o coordenador do grupo, abra uma issue neste repositório ou procure os professores orientadores:

- **Orientador:** Professor Dr. Cleber Silva de Oliveira — cleber@ifsp.edu.br  
- **Coorientador:** Professor Dr. Thiago Schumacher Barcelos — tsbarcelos@ifsp.edu.br

---

Bons estudos e boas análises!
