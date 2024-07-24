# Docker-Jupyter
Neste projeto utilizo a ferramenta Docker para criar um container Jupyter e um conatiner database Postgresql. O container Jupyter é configurado para se comunicar com cluster containerizado SPARK do projeto Docker-ClusterSpark do meu repositorio https://github.com/LeonardoNunes-N/Docker-ClusterSpark.git

Crio uma imagem personalizada no DockerFile com as configuracoes especificas para meu projeto utilizando python:3.11-bullseye. Nele instalo dependencias necessarias e configuro o ambiente spark o container se comunicar com a Master. 

Arquivos necessarios para rodar o Dockerfile é requirements.txt, spark-default.conf e entrypoint.sh 

#####O requirements.txt possui os mesmas configuracoes do requirements.txt do cluster.#####

*Configuracao SSH 
Para configuracoes SSH foi necessario adicionar linhas de comando no entrypoint.sh 

O ssh no conteiner tem suas peculiaridades, sendo necessario configuracao nas pastas /etc/ssh/sshd_config, /etc/pam.d/sshd e /etc/profile

Gerei uma chave publica ssh para a conexao host e container, havendo mais seguranca na minha conexao, criei uma pasta /ssh/authorized_key que possui o valor da chave, é exigido tambem configuracao de permissionamento rwx.

chmod 600: O proprietário do arquivo tem permissão total para ler e escrever no arquivo (rw-) e nenhum acesso é permitido para grupos de usuários ou para outros (---).
chmod700: O proprietário do arquivo tem permissão total para ler, escrever e executar o arquivo (rwx) e nenhum acesso é permitido para grupos de usuários ou para outros (---).

*Configuracoes Git 
Foi adicionado linhas de comando do entrypoint.sh para configurar o git, utilizo variaveis de ambiente do container jupyter para referenciar os valores. Segue sua Estrutura: 

SPARK_NO_DAEMONIZE=true
POSTGRES_USER=**********
POSTGRES_PASSWORD=******
POSTGRES_DB=********
GIT_USER_NAME=*************
GIT_USER_EMAIL=**********************
CASEDIR=*****************************
GITREMOTE=***************************************
GITHUB_TOKEN=***********************************

Logo apos a configuracao do Git é iniciado o Jupyter server.

*Docker-compose

Aqui é configurado portas, volumes, imagem, poder computacional de cada container: Jupyter e Postgresql.

O database utiliza a imagem do 'postgres:latest', para a percistencia de dados é utilizado uma pasta entre o host e o container configurado no volume. Dois arquivos sao utilizados para o container do database, .env para as credencias do banco de dados e init.sql para ser o script que sera rodado no banco assim que iniciar o container.

*Rede Personalizada 

Utilizo a rede que foi criada no docker-compose do cluster um ambiente aberto a conexoes externas e nao somente local, todos os containers estao na mesma rede, tendo ip fixo para conexoes ssh atraves do ip e nao somente LocalHost. 

################################################################################################################################################################################

Esse projeto foi desenvolvido com intuito de ser a primeira parte de um Case, para assim estruturar um ambiente para processos de ETL. É possivel utilizar esse ambiente para diversos projetos. Caso tenha interesse, a segunda parte do Case que possui o desenvolvimento esta no Repositorio https://github.com/LeonardoNunes-N/Case_deVaga.git.
























