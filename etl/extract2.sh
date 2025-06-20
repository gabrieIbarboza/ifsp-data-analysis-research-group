#!/bin/bash
echo "===============NORMALIZE ENCODING================"
iconv -f ISO-8859-1 -t UTF-8 Nacionalidade.csv > ./utf8/Nacionalidade.csv
iconv -f ISO-8859-1 -t UTF-8 Ocupacao.csv > ./utf8/Ocupacao.csv

echo "===============TRANSFORM================"
./csvtosql/csvtosql-bin   Idade.csv > ./sql/idade.sql
./csvtosql/csvtosql-bin  ./utf8/Nacionalidade.csv > ./sql/nacionalidade.sql
./csvtosql/csvtosql-bin  ./utf8/Ocupacao.csv > ./sql/ocupacao.sql


echo "================LOADER=================="
mysql -u root --password=Fthyy*83 sim_data  < ./sql/idade.sql
mysql -u root --password=Fthyy*83 sim_data  < ./sql/nacionalidade.sql
mysql -u root --password=Fthyy*83 sim_data  < ./sql/ocupacao.sql

echo "================ CONTAGEM VALIDAÇÃO ARQUIVOS =================="
echo 'Idade'
wc -l Idade.csv
wc -l ./sql/idade.sql

echo 'Nac'
wc -l ./utf8/Nacionalidade.csv
wc -l ./sql/nacionalidade.sql

echo 'ocup'
wc -l ./utf8/Ocupacao.csv
wc -l ./sql/ocupacao.sql


sleep 10

