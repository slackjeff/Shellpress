#!/usr/bin/env bash
#=========================================================================
# Autor:    Jefferson Carneiro <slackjeff@slackjeff.com.br>
# Programa: ShellPress
#
# Script verificado com ShellCheck (02/08/2025)
# Aprovado com: shellcheck -x shellpress.sh
# shellcheck disable=SC2034,SC1090,SC1091
#=========================================================================
set -e

#=====================================
# Variaveis de Ambiente do projeto
#=====================================
PRG_NAME="shellpress"
PRG_VERSION='4.0'
ROOT_DIR="$(pwd)"
SRC_DIR="$ROOT_DIR/pages"
PUBLIC_DIR="$ROOT_DIR/public"
CONFIG_FILE="${ROOT_DIR}/shellpress.config"

# Cores FG
# shellcheck disable=SC2034
fgRed='\e[031;1m'
fgGreen='\e[032;1m'
fgYellow='\e[033;1m'
fgEnd='\e[m'
#=====================================
# Carregando configurações
#=====================================
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo -e "${fgRed} Arquivo de configuração $CONFIG_FILE$ não encontrado em ${ROOT_DIR}{fgEnd}"
    exit 1
fi

#=====================================
# Carregando Módulos
#=====================================
source "${ROOT_DIR}/lib/core/core.sh"


#=====================================
# Funções
#=====================================

function HELP()
{
    cat <<help
$PRG_NAME - $PRG_VERSION
USO: $PRG_NAME [OPÇÃO]

  --generate-all      Gera todas as páginas HTML baseadas nos arquivos de 'pages/'.
  --generate-videos   [Módulo] Gera apenas a página de vídeos integrada ao YouTube.

  --blog              [Módulo] Inicia o gerenciador interativo de postagens do blog (criar, listar, publicar).
  --help,help         Exibe esta ajuda.
help

    exit 0

} # Fecha Help


function DIE()
{
    local msg="$*"

    echo -e "---> ${fgRed}$msg${fgEnd}"
    exit 1
}  # Fecha Die

#=====================================
# Inicio
#=====================================

if [[ "$#" -eq 0 ]]; then
    DIE "Consulte 'help'"
fi

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --blog)
            if [[ "$BLOG" = 'off' ]]; then
                DIE "Módulo Blog está setado como 'off' em: ${CONFIG_FILE}"
            else
                bash lib/modules/build-blog.sh
            fi
        ;;
        --generate-videos)
            out_dir="${PUBLIC_DIR}/videos"
            out_file="${out_dir}/index.html"
            [[ ! -d "$out_dir" ]] && mkdir -vp "$out_dir"

            if [[ "$VIDEO_PAGE" = 'on' ]]; then
                echo
                echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                echo "Gerando: Lista de Videos"
                echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                {
                    HEADER
                    MENU
                    echo "✅ Gerando Página de últimos videos"
                    bash lib/modules/fetch-youtube-videos.sh
                    FOOTER
                } > "${out_file}"
            else
                DIE "Módulo Video desabilitado no arquivo de configuração."
            fi
        ;;

        --generate-all)
            for html_page in "${SRC_DIR}"/*; do
                # Pegue o nome do arquivo somente sem extensão
                # Vamos usar para criar o diretorio.
                page_name="$(basename "${html_page%.html}")"

                # Arquivo index.html precisa ficar na raiz
                # e não deve gerar diretorio.
                if [[ "$page_name" = "index" ]]; then
                    out_file="${PUBLIC_DIR}/index.html"
                else
                    out_dir="${PUBLIC_DIR}/$page_name"
                    out_file="${out_dir}/index.html"
                    # Cria o diretório, se necessário
                    [[ ! -d "$out_dir" ]] && mkdir -pv "$out_dir"
                fi
                # Vamos começar gerar o conteudo agora.

                # Precisa ser gerado a parte.
                if [[ "$page_name" = "videos" ]]; then
                    continue
                fi
                echo
                echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                echo "Gerando: $page_name"
                echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                echo "✅ [Build] Página estática"
                {
                    HEADER
                    MENU
                    cat "$html_page"
                    FOOTER
                } > "${out_file}"
            done
        ;;

        --help|help)
            HELP
        ;;

        *)
            DIE "Argumento desconhecido! Consulte help."
        ;;
    esac
    shift
done

