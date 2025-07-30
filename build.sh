#!/bin/bash
#=========================================================================
# Autor:    Jefferson Carneiro <slackjeff@slackjeff.com.br>
# Programa: ShellPress
# Descrição:
#
#=========================================================================
set -e

#=====================================
# Variaveis de Ambiente do projeto
#=====================================
PRG_NAME="shellpress"
PRG_VERSION='3.0'
ROOT_DIR="$(pwd)"
SRC_DIR="$ROOT_DIR/pages"
PUBLIC_DIR="$ROOT_DIR/public"
CONFIG_FILE="${ROOT_DIR}/shellpress.config"

#=====================================
# Carregando configurações
#=====================================
if [ -f "$CONFIG_FILE" ]; then
    source $CONFIG_FILE
else
    echo "❌ Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

#=====================================
# Inicio
#=====================================

cat <<'EOF'
  ____  _          _ _ ____
 / ___|| |__   ___| | |  _ \ _ __ ___  ___ ___
 \___ \| '_ \ / _ \ | | |_) | '__/ _ \/ __/ __|
  ___) | | | |  __/ | |  __/| | |  __/\__ \__ \
 |____/|_| |_|\___|_|_|_|   |_|  \___||___/___/
EOF
echo "$PRG_NAME - $PRG_VERSION"
echo

int='0'
for pages in ${SRC_DIR}/*; do
    int=$((int+1))
    # Pegue somente o nome do arquivo (file.html)
    page="$(basename $pages)"

    echo "################################"
    echo " Construindo: $page"
    echo "################################"

    echo " ✅ Gerando Header"
    bash core/header.sh > ${PUBLIC_DIR}/$page

    # Menu
    if [ "$MENU" = 'on' ]; then
    	echo " ✅ > Gerando Menu"
    	bash core/menu.sh >> ${PUBLIC_DIR}/$page
    fi

    echo " ✅ > Construindo Página estática"
    cat $pages >> ${PUBLIC_DIR}/$page

######## TODO
# Fazer um script central de hooks
# aonde chama os módulos plugin e play.
########
    # Videos
    if [ "$page" = "videos.html" ]; then
    	if [ "$VIDEO_PAGE" = 'on' ]; then
             echo " ✅ > Gerando Página de últimos 6 videos"
    	     bash modules/fetch-youtube-videos.sh >> ${PUBLIC_DIR}/$page
        fi
    fi

    echo " ✅ > Gerando Footer"
    bash core/footer.sh >> ${PUBLIC_DIR}/$page
done

echo
echo "#=================================================#"
echo " Ao total foram geradas: $int páginas"
echo "#=================================================#"
echo
