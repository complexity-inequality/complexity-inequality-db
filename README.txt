



dockerfile - mongoDB

sudo docker build . -t mongoDB:v20210807
 -p 27017:27017 -v $(pwd):/data/db

sudo docker build . -t rstudio-custom:v20210101
sudo docker run -d -e PASSWORD=minhasenha -p 8787:8787 -v $(pwd):/home/rstudio/ 4fc3047afdf3
sudo docker run -d -e PASSWORD=minhasenha -p 8787:8787 -v $(pwd):/home/rstudio/ --name=rstudio_container 4fc3047afdf3



# install pyspark
# https://phoenixnap.com/kb/install-spark-on-ubuntu
# sudo apt install default-jdk scala git -y
# wget https://downloads.apache.org/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz
# wget https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
sudo apt install default-jre

py4j





______________________________________________________________________

1) Microdados do censo da educação superior (https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior); 
2) IDD - Microdados do Indicador da Diferença entre os Desempenhos observados e esperados (https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/idd)
x3 -- 3) Tabela 1383 - Taxa de alfabetização das pessoas de 10 anos ou mais de idade por sexo (https://sidra.ibge.gov.br/Tabela/1383)
v4) Tabela 1554 - Pessoas de 10 anos ou mais de idade, por nível de instrução - Resultados Gerais da Amostra - (https://sidra.ibge.gov.br/Tabela/1554)
5) Tabela 1699 - Pessoas de 10 anos ou mais de idade, total, alfabetizadas e Taxa de alfabetização por sexo (https://sidra.ibge.gov.br/Tabela/1699)
6) Tabela 1972 - Pessoas que frequentavam creche ou escola por nível e rede de ensino (https://sidra.ibge.gov.br/Tabela/1972) ***
7) Tabela 2976 - Pessoas que frequentavam creche ou escola por nível de ensino, situação do domicílio e grupos de idade (https://sidra.ibge.gov.br/Tabela/2976)
8) Tabela 2977 - Pessoas que frequentavam creche ou escola por nível de ensino, cor ou raça e grupos de idade (https://sidra.ibge.gov.br/Tabela/2977)
9) Tabela 3214 - Pessoas de 5 anos ou mais de idade, residentes em domicílios particulares, cuja condição no domicílio não era pensionista, nem empregado(a) doméstico(a) ou seu parente, por classes de rendimento nominal mensal domiciliar per capita, segundo a condição de alfabetização e a idade (https://sidra.ibge.gov.br/Tabela/3214)
10) Tabela 3536 - Pessoas que frequentavam creche ou escola, por situação do domicílio e rede de ensino, segundo o sexo, a cor ou raça, o curso que frequentavam e os grupos de idade (https://sidra.ibge.gov.br/Tabela/3536)
v(na fila) --> 11) Tabela 3537 - Pessoas residentes em domicílios particulares, que frequentavam escola ou creche, exclusive as cuja condição no domicílio era pensionista, empregado(a) doméstico(a) ou parente do(a) empregado(a) doméstico(a), por classes de rendimento nominal mensal domiciliar per capita, segundo a rede de ensino e o curso que frequentavam (https://sidra.ibge.gov.br/Tabela/3537)
URL1: https://sidra.ibge.gov.br/Tabela/3537
URL2: https://sidra.ibge.gov.br/geratabela?format=us.csv&name=tabela3537.csv&terr=NC&rank=-&query=t/3537/n6/all/v/allxp/p/all/c386/all/c11797/all/c11322/0,14432,121405,121407,121408/d/v1474%200/l/v,p%2Bc386%2Bc11797,t%2Bc11322

12) Tabela 3539 - Pessoas de 10 anos ou mais de idade, por frequência à escola e situação de ocupação na semana de referência, segundo o sexo, e os grupos de idade (https://sidra.ibge.gov.br/Tabela/3539)
v13) Tabela 3543 - Pessoas com pelo menos nível superior de graduação concluído, por nível de instrução mais elevado concluído, segundo o sexo e as áreas gerais, específicas e detalhadas de formação do curso de nível mais elevado concluído (https://sidra.ibge.gov.br/Tabela/3543)
14) Tabela 3544 - População residente, por grupos de idade, segundo a frequência à escola ou creche e curso e série que frequentavam (https://sidra.ibge.gov.br/Tabela/3544)
v15) Tabela 3545 - Pessoas de 10 anos ou mais de idade, que frequentavam escola, por grupos de idade, segundo a situação de ocupação na semana de referência e o curso que frequentavam (https://sidra.ibge.gov.br/Tabela/3545)
v (absorvida) 16) Tabela 631 - População residente, por sexo e lugar de nascimento (https://sidra.ibge.gov.br/Tabela/631)
v17) Tabela 1497 - População residente, por nacionalidade - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/1497)
v18) Tabela 1505 - População residente, por naturalidade em relação ao município e à unidade da federação - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/1505)
19) Tabela 1535 - Pessoas não naturais da unidade da federação, por tempo ininterrupto de residência na unidade da federação - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/1535)
v20) Tabela 1611 - Pessoas que frequentavam escola ou creche, por local da escola ou creche que frequentavam - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/1611)
v21) Tabela 1615 - Pessoas ocupadas na semana de referência, por local de exercício do trabalho principal - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/1615)
22) Tabela 3180 - População residente, por nacionalidade, sexo e grupos de idade (https://sidra.ibge.gov.br/Tabela/3180)
x 23) Tabela 3389 - Pessoas ocupadas na semana de referência, por local de exercício do trabalho principal (https://sidra.ibge.gov.br/Tabela/3389)
24) Tabela 3422 - Pessoas ocupadas na semana de referência, que trabalhavam fora do domicílio e retornavam para seu domicílio diariamente, por tempo habitual de deslocamento para o trabalho - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/3422)
x 25) (https://sidra.ibge.gov.br/Tabela/1936)
v 26) Tabela 4009 - Domicílios particulares permanentes, com rendimento domiciliar, Valor do rendimento nominal médio mensal e Valor do rendimento nominal mediano mensal dos domicílios particulares permanentes, com rendimento domiciliar, por situação do domicílio e tipo do setor - Resultados Gerais da Amostra (https://sidra.ibge.gov.br/Tabela/4009)
x (fazer o calc eu mesmo) 27) Tabela 1301 - Área e Densidade demográfica da unidade territorial (https://sidra.ibge.gov.br/Tabela/1301)
v (wip) 28) Tabela 3604 - Pessoas de 10 anos ou mais de idade, ocupadas na semana de referência, que, no trabalho principal, trabalhavam fora do domicílio e retornavam diariamente do trabalho para o domicílio, exclusive as pessoas que, no trabalho principal, trabalhavam em mais de um município ou país, por tempo habitual de deslocamento do domicílio para o trabalho principal, segundo a situação do domicílio e os grupos de horas habitualmente trabalhadas por semana no trabalho principal (https://sidra.ibge.gov.br/Tabela/3604)
x 29) Tabela 3602 - Pessoas de 10 anos ou mais de idade, ocupadas na semana de referência, por local de exercício do trabalho principal e sexo, segundo a cor ou raça, o nível de instrução, os grupos de idade e a seção de atividade do trabalho principal (https://sidra.ibge.gov.br/Tabela/3602)
v 30) Tabela 3599 - Pessoas residentes em domicílios particulares, que frequentavam escola ou creche, por situação do domicílio e sexo, segundo o local da escola ou creche que frequentavam, a cor ou raça, os grupos de idade e o curso que frequentavam (https://sidra.ibge.gov.br/Tabela/3599)
31) Tabela 3596 - Pessoas residentes em domicílios particulares, que frequentavam escola ou creche, exclusive as pessoas cuja condição no domicílio era pensionista, empregado(a) doméstico(a) ou seu parente, por local da escola ou creche que frequentavam, segundo a situação do domicílio e as classes de rendimento nominal mensal domiciliar per capita (https://sidra.ibge.gov.br/Tabela/3596)


Estatisticas do trabalho, pegar no rais