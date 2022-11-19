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
