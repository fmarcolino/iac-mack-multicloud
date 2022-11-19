# iac-mack-multicloud

Este trabalho tem como objetivo usar IaC para provisionar máquinas em duas Cloud Providers.

# Arquitetura proposta
![Architecture](images/architecture.png?raw=true "Architecture")

# Provedoras adotadas

- Cloud 1: AWS
- Cloud 2: Azure

# Automação da infraestrutura

Foi escolhido o Terraform para criar recursos em ambas as provedoras.

A escolha foi devido ao state do terraform para aplicar somente quando for necessário, na facilidade de criar e destruir recursos em dois simples comandos.


# Como executar o projeto

## instalar o terraform

Recomendo usar o `tfswitch` para gerenciar as versões do Terraform.

```bash
brew install warrensbox/tap/tfswitch
```

Após, poderá usar o comando `tfswitch x.x.x` para instalar a versão desejada, ou `tfswitch -u` para instalar a última versão estável disponível do Terraform.

## instalar o cli da aws

Se for pelo Mac Os:

```bash
brew install awscli
```

Para outros sistemas, procure a documentação da Aws Cli.

## instalar cli da Azure

Se for pelo Mac Os:

```bash
brew install azure-cli
```

Para outros sistemas, procure a documentação da Azure Cli.

## Configuração de credenciais

Para a AWS, foi necessária a criação de um usuário programático com as seguintes políticas:

```bash
AmazonSSMReadOnlyAccess
AmazonEC2FullAccess
AmazonS3FullAccess
AmazonVPCFullAccess
```

Após a obtenção das credenciais AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY, basta exportá-las no terminal que a aws-cli já consegue usá-las, ou caso deseje, poderá usar o comando `aws configure`. 

Para a Azure, basta rodar o comando `az login` no terminal.

# Comandos terraform

## Inicializar terraform

```bash
terraform init
```

## Realizar o plan

```bash
terraform plan
```

## Aplicar

```bash
terraform apply
```

![Terraform Output](images/terraform-output.png?raw=true "Terraform Output")

## Verifique os resultados

1. Execute a saída do terraform para obter a chave privada SSH e salvá-la em um arquivo.

```bash
terraform output -raw tls_private_key > id_rsa
```

2. Execute a saída do terraform para obter o endereço IP público da máquina virtual.

```bash
terraform output azure_deck_ip
terraform output aws_php_ip
terraform output aws_jenkins_ip
```

3. Use SSH para se conectar à máquina virtual.

```bash
ssh -i id_rsa azureuser@<azure_deck_ip>
ssh -i id_rsa ec2-user@<aws_php_ip>
ssh -i id_rsa ec2-user@<aws_jenkins_ip>
```

4. Dependendo das permissões do seu ambiente, você pode receber um erro ao tentar usar SSH para entrar na máquina virtual com o arquivo de chave id_rsa. Se você receber um erro informando que o arquivo de chave privada está desprotegido e não pode ser usado, tente executar o comando chmod 600 id_rsa, que restringirá o acesso de leitura e gravação ao proprietário do arquivo.

5. Verifique o status dos serviços em cada máquina

```bash
# ssh -i id_rsa azureuser@<azure_deck_ip>
sudo systemctl status rundeckd
```

```bash
# ssh -i id_rsa ec2-user@<aws_php_ip>
sudo systemctl status httpd
sudo systemctl status mariadb
```

```bash
# ssh -i id_rsa ec2-user@<aws_jenkins_ip>
sudo systemctl status jenkins
```

6. Acesse os serviços pelo browser (estão rodando em subnets públicas)

```bash
http://<azure_deck_ip>:4440
```

![Rundeck](images/rundeck.png?raw=true "Rundeck")

```bash
http://<aws_php_ip> # Porta 80
```

![Php](images/php.png?raw=true "Php")

```bash
http://<aws_jenkins_ip>:8080
```

![Jenkins](images/jenkins.png?raw=true "Jenkins")

7. Verifique os recursos em cada console das clouds.

## Limpar os recursos

```bash
terraform destroy
```
