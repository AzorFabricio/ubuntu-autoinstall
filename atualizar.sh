#!/usr/bin/env bash
#
# Atualização do sistema operacional e dos aplicativos
# Compatível com Ubuntu e Linux Mint.
#
# Uso:
#   chmod +x atualizar-sistema.sh
#   ./atualizar-sistema.sh
#

set -Eeuo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

log()   { printf "${BLUE}[INFO]${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}[AVISO]${RESET} %s\n" "$*"; }
error() { printf "${RED}[ERRO]${RESET} %s\n" "$*" >&2; }

on_error() {
    error "Ocorreu uma falha na linha ${BASH_LINENO[0]:-desconhecida}. Verifique as mensagens acima."
    exit 1
}
trap on_error ERR

# Confere se o sistema é baseado em Debian/Ubuntu.
if [[ ! -r /etc/os-release ]]; then
    error "Não foi possível identificar o sistema operacional."
    exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release
case "${ID:-}" in
    ubuntu|linuxmint|lmde) ;;
    *)
        if [[ " ${ID_LIKE:-} " != *" ubuntu "* && " ${ID_LIKE:-} " != *" debian "* ]]; then
            error "Este script foi preparado para Ubuntu e Linux Mint."
            exit 1
        fi
        ;;
esac

if ! command -v apt-get >/dev/null 2>&1; then
    error "O comando apt-get não está disponível."
    exit 1
fi

printf '\n'
printf '%s\n' "=============================================="
printf '%s\n' " Atualização do Ubuntu / Linux Mint"
printf '%s\n' "=============================================="
printf 'Sistema detectado: %s\n\n' "${PRETTY_NAME:-Linux}"

# Solicita autenticação uma única vez e mantém a credencial ativa durante a execução.
log "Solicitando autorização administrativa. Digite sua senha quando solicitado."
sudo -v

# Mantém a autenticação sudo ativa enquanto o script estiver em execução.
while true; do
    sudo -n true 2>/dev/null || exit
    sleep 45
    sudo -n -v 2>/dev/null || true
done &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT

export DEBIAN_FRONTEND=noninteractive

log "Atualizando a lista de pacotes..."
sudo -n apt-get update

log "Instalando atualizações disponíveis..."
sudo -n apt-get -y upgrade

log "Aplicando atualizações que exigem alteração de dependências..."
sudo -n apt-get -y full-upgrade

log "Removendo dependências que não são mais necessárias..."
sudo -n apt-get -y autoremove --purge

log "Limpando arquivos de pacotes baixados que não são mais necessários..."
sudo -n apt-get autoclean

# Atualiza pacotes Snap, caso o Snap esteja instalado.
if command -v snap >/dev/null 2>&1; then
    log "Atualizando aplicativos Snap..."
    if ! sudo -n snap refresh; then
        warn "Não foi possível atualizar todos os aplicativos Snap. Consulte as mensagens acima."
    fi
else
    log "Snap não está instalado; etapa ignorada."
fi

# Atualiza aplicativos Flatpak, caso o Flatpak esteja instalado.
if command -v flatpak >/dev/null 2>&1; then
    log "Atualizando aplicativos Flatpak..."
    if ! flatpak update -y; then
        warn "Não foi possível atualizar todos os aplicativos Flatpak. Consulte as mensagens acima."
    fi
else
    log "Flatpak não está instalado; etapa ignorada."
fi

printf '\n'
ok "Processo de atualização concluído."
printf '\n'

# Informa se o sistema recomenda reinicialização.
if [[ -e /var/run/reboot-required ]]; then
    warn "O sistema recomenda reinicialização para concluir algumas atualizações."
    if [[ -r /var/run/reboot-required.pkgs ]]; then
        printf 'Pacotes que solicitaram reinicialização:\n'
        cat /var/run/reboot-required.pkgs
    fi
else
    ok "Não foi identificado um aviso de reinicialização pendente."
fi

printf '\n%s\n' "Você pode fechar esta janela. Reinicie o computador se necessário."

#!/usr/bin/env bash
#
# Instala e executa o Neofetch no Ubuntu 26.04 ou Linux Mint.
# Usa o APT quando o pacote estiver disponível. Se não estiver, informa
# claramente que o Neofetch foi descontinuado e oferece o Fastfetch como alternativa,
# sem instalar fontes de terceiros automaticamente.
#
# Uso:
#   chmod +x instalar-executar-neofetch.sh
#   ./instalar-executar-neofetch.sh
#

set -Eeuo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

info()  { printf "${BLUE}[INFO]${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}[AVISO]${RESET} %s\n" "$*"; }
error() { printf "${RED}[ERRO]${RESET} %s\n" "$*" >&2; }

on_error() {
    error "Falha na linha ${BASH_LINENO[0]:-desconhecida}. Verifique as mensagens anteriores."
    exit 1
}
trap on_error ERR

if [[ ! -r /etc/os-release ]]; then
    error "Não foi possível identificar a distribuição Linux."
    exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release

case "${ID:-}" in
    ubuntu|linuxmint|lmde) ;;
    *)
        if [[ " ${ID_LIKE:-} " != *" ubuntu "* && " ${ID_LIKE:-} " != *" debian "* ]]; then
            error "Este script foi preparado para Ubuntu 26.04 e Linux Mint."
            exit 1
        fi
        ;;
esac

if ! command -v apt-get >/dev/null 2>&1; then
    error "O gerenciador de pacotes APT não está disponível."
    exit 1
fi

printf '\n============================================\n'
printf ' Instalar e executar o Neofetch\n'
printf ' Sistema: %s\n' "${PRETTY_NAME:-Ubuntu/Linux Mint}"
printf '============================================\n\n'

info "Solicitando autorização administrativa..."
sudo -v

export DEBIAN_FRONTEND=noninteractive

info "Atualizando a lista de pacotes..."
sudo apt-get update

if ! command -v neofetch >/dev/null 2>&1; then
    info "Verificando se o pacote Neofetch está disponível no APT..."
    if apt-cache show neofetch >/dev/null 2>&1; then
        info "Instalando o Neofetch..."
        sudo apt-get install -y neofetch
    else
        warn "O pacote Neofetch não está disponível nos repositórios APT configurados."
        warn "O Neofetch foi descontinuado e pode não estar incluído nas versões recentes."
        printf '\n'
        read -r -p "Deseja instalar e executar o Fastfetch como alternativa? [s/N]: " resposta
        case "${resposta,,}" in
            s|sim|y|yes)
                info "Instalando o Fastfetch..."
                if apt-cache show fastfetch >/dev/null 2>&1; then
                    sudo apt-get install -y fastfetch
                    ok "Fastfetch instalado. Exibindo as informações do sistema:"
                    fastfetch
                    exit 0
                else
                    error "O pacote Fastfetch também não está disponível nos repositórios configurados."
                    warn "Ative os repositórios oficiais apropriados para sua distribuição e tente novamente."
                    exit 1
                fi
                ;;
            *)
                error "Instalação cancelada. Nenhum repositório externo foi adicionado."
                exit 1
                ;;
        esac
    fi
else
    ok "O Neofetch já está instalado."
fi

if ! command -v neofetch >/dev/null 2>&1; then
    error "O comando neofetch não foi encontrado após a instalação."
    exit 1
fi

printf '\n'
ok "Neofetch instalado. Exibindo as informações do sistema:"
printf '\n'
neofetch
