### Documentação README para Configuração Terraform de AppServer + MySQL EC2

---

# Configuração Terraform de AppServer + MySQL EC2

Esta configuração do Terraform implanta um servidor de aplicação e um servidor MySQL em instâncias Amazon EC2. Também configura a VPC necessária, grupos de segurança, IPs Elásticos e registros DNS usando AWS Route 53.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) instalado
- AWS CLI configurado com acesso apropriado
- Par de chaves SSH criado e acessível
- ID da Zona Hospedada no Route 53 para criação de registros DNS

## Módulos

- **Módulo VPC**: Cria a VPC, sub-redes e outros componentes de rede.
- **Módulo EC2**: Lança instâncias EC2 para o servidor de aplicação e servidor MySQL.
- **Grupos de Segurança**: Configura grupos de segurança com regras específicas para o servidor de aplicação e servidor MySQL.

## Uso

### Variáveis

- `cliente_nome`: Nome do cliente para tagging e nomeação dos recursos.
- `regiao`: Região AWS onde os recursos serão implantados.
- `tipo_ambiente`: Tipo de ambiente (ex: dev, prod).
- `key_name`: Nome do par de chaves SSH para acesso às instâncias.
- `cliente_nome_inteiro`: Nome completo do cliente para os registros DNS.

### Implantação

1. Clone o repositório contendo a configuração do Terraform.

2. Inicialize o Terraform:

    ```bash
    terraform init
    ```

3. Revise o plano:

    ```bash
    terraform plan
    ```

4. Aplique a configuração:

    ```bash
    terraform apply
    ```

5. Confirme a implantação digitando `yes` quando solicitado.

### Saídas

- Endereços IP públicos do servidor de aplicação e servidor MySQL.
- Nomes DNS para o servidor de aplicação e servidor MySQL.

### Limpeza

Para destruir os recursos criados por esta configuração do Terraform:

```bash
terraform destroy
```

## Considerações de Segurança

### Revisão do Código para Segurança

- **IDs de AMI**: A variável `ami` para ambas as instâncias EC2 está vazia. É necessário especificar uma AMI válida, atualizada e segura para o servidor de aplicação e para o servidor MySQL.
  
- **Grupos de Segurança**:
  - As regras de ingresso para o grupo de segurança do servidor de aplicação permitem acesso de `0.0.0.0/0` nas portas 3389 (RDP), 80 (HTTP), 8172 (Web Deploy) e 443 (HTTPS). Permitir acesso irrestrito (`0.0.0.0/0`) representa um risco significativo de segurança. Recomenda-se restringir o acesso a endereços IP confiáveis.
  - O grupo de segurança do servidor MySQL permite acesso SSH (porta 22) e acesso MySQL (portas 3306, 33060) de `0.0.0.0/0`, o que também representa um risco de segurança. Considere restringir o acesso a IPs específicos ou usar uma VPN.
  
- **IPs Elásticos**: IPs públicos estão sendo atribuídos tanto ao servidor de aplicação quanto ao servidor MySQL. Certifique-se de que isso é necessário para sua arquitetura e esteja ciente da exposição à internet.

- **Registros DNS no Route 53**: Verifique se o `zone_id` para os registros do Route 53 está configurado corretamente e se os registros DNS são expostos apenas conforme necessário.

---

Este README fornece uma visão geral básica da configuração do Terraform. Ajuste as configurações de segurança e infraestrutura de acordo com seus requisitos específicos e as melhores práticas de segurança.