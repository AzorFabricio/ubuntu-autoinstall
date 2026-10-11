# 🐧 Scripts Linux — Ubuntu e Linux Mint

Scripts automatizados em Bash para facilitar a manutenção e a administração de sistemas Linux, com foco em Ubuntu e Linux Mint.

O projeto reúne ferramentas para atualizar o sistema operacional, manter aplicativos atualizados e consultar informações do computador pelo terminal.

## 🚀 Funcionalidades

### 1. Atualização do sistema

Script `atualizar-sistema.sh`

- Atualiza a lista de pacotes com `apt-get update`.
- Instala atualizações disponíveis com `apt-get upgrade`.
- Aplica atualizações de dependências com `apt-get full-upgrade`.
- Remove pacotes desnecessários com `apt-get autoremove --purge`.
- Limpa arquivos de pacotes baixados com `apt-get autoclean`.
- Atualiza aplicativos Snap, quando instalado.
- Atualiza aplicativos Flatpak, quando instalado.
- Verifica se o sistema recomenda reinicialização.
- Exibe mensagens coloridas de status, avisos e erros.

### 2. Instalação e execução do Neofetch

Script `instalar-executar-neofetch.sh`

- Verifica a distribuição Linux e a disponibilidade do APT.
- Atualiza a lista de pacotes.
- Verifica se o Neofetch já está instalado.
- Instala o Neofetch quando disponível nos repositórios configurados.
- Oferece o Fastfetch como alternativa caso o Neofetch não esteja disponível.
- Exibe informações do sistema no terminal.
- Evita adicionar repositórios externos automaticamente.

## 💻 Sistemas compatíveis

- Ubuntu
- Linux Mint
- LMDE (Linux Mint Debian Edition), conforme as verificações implementadas nos scripts.
- Outras distribuições baseadas em Debian ou Ubuntu que atendam às verificações de compatibilidade.

**Requisitos:**
- Terminal Linux.
- Bash.
- APT (`apt-get`).
- `sudo` e permissões administrativas para as operações de manutenção.
- Conexão com a internet para baixar atualizações e pacotes.

A disponibilidade dos pacotes pode variar conforme a versão do sistema e os repositórios configurados.

## 📥 Instalação

Clone o repositório:

```bash
git clone https://github.com/SEU-USUARIO/scripts-linux-ubuntu-linux-mint.git
```

Entre na pasta:

```bash
cd scripts-linux-ubuntu-linux-mint
```

Conceda permissão de execução aos scripts:

```bash
chmod +x atualizar-sistema.sh
chmod +x instalar-executar-neofetch.sh
```

## ▶️ Como utilizar

### Atualizar o sistema

Execute:

```bash
./atualizar-sistema.sh
```

Digite sua senha quando o `sudo` solicitar autorização.

### Instalar e executar o Neofetch

Execute:

```bash
./instalar-executar-neofetch.sh
```

Se o Neofetch não estiver disponível, o script poderá oferecer a instalação do Fastfetch, desde que o pacote esteja disponível nos repositórios configurados.

## ⚠️ Avisos importantes

- Faça backup dos seus arquivos importantes antes de executar operações de manutenção.
- Revise as alterações de pacotes caso precise de controle rigoroso sobre atualizações.
- O comando `full-upgrade` pode instalar ou remover pacotes para resolver dependências.
- O comando `autoremove --purge` pode remover pacotes considerados desnecessários pelo APT.
- Os scripts precisam de permissões administrativas para determinadas operações.
- O Fastfetch é uma alternativa ao Neofetch para exibir informações do sistema, mas não é uma substituição idêntica em todos os detalhes.

Execute os scripts por sua conta e risco e leia o código antes de utilizá-los em computadores de produção.

## 🛠️ Tecnologias utilizadas

- GNU Bash
- Linux
- APT / apt-get
- Snap
- Flatpak
- Neofetch
- Fastfetch
- Git e GitHub

## 🤝 Contribuições

Contribuições são bem-vindas!

1. Faça um fork do repositório.
2. Crie uma branch para sua alteração.
3. Implemente e teste suas modificações.
4. Envie um Pull Request com uma descrição das mudanças.

## 📄 Licença

Este projeto ainda não especifica uma licença. Antes de permitir reutilização, distribuição ou modificação por terceiros, escolha uma licença de código aberto e adicione o respectivo arquivo `LICENSE`.

---

**Desenvolvido para facilitar a manutenção e o uso diário do Linux.**
