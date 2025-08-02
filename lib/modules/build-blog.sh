#!/usr/bin/env bash
#====================================================================
# Autor:
#  Jefferson Carneiro <slackjeff@slackjeff.com.br>
#
# Descrição:
#  Módulo para criar um blog no site utilizando markdown...
#   - Criação de post
#   - Sistema de draft
#
# Script verificado com ShellCheck (02/08/2025)
# Aprovado com: shellcheck -s bash build-blog.sh
#
# shellcheck disable=SC1091
#====================================================================

#===========================#
# Variaveis Globais
#===========================#
EDITOR="${EDITOR:-nano}"
AUTHOR="Jefferson Carneiro" # Autor da postagem
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${BASE_DIR}/public/blog"
DRAFT_DIR="${BASE_DIR}/blog/draft"

#===========================#
# TESTES
#===========================#
# Verificando se todos diretórios
# necessários existem. Se não crie.
for check_dir in "blog" "blog/draft"; do
    if [[ ! -d "${BASE_DIR}/$check_dir" ]]; then
        mkdir -pv "${BASE_DIR}/$check_dir"
    fi
done

# Programa markdown é necessário no sistema!
for check_pg in 'markdown' 'xmlstarlet'; do
    if ! which $check_pg &>/dev/null; then
        echo "Instale o utilitário '$check_pg'"
        exit 1
    fi
done

#===========================#
# Carregando Módulo Core
#===========================#
source "${BASE_DIR}/lib/core/core.sh"

#===========================#
# FUNÇÕES
#===========================#

function NEW_POST_TEMPLATE()
{
    temp_title="$1"
    temp_slug="$(echo $RANDOM | md5sum | cut -d' ' -f1)"

    echo "📌 Criado arquivo ${DRAFT_DIR}/${temp_slug}.md"
    cat << TEMPLATE > "${DRAFT_DIR}/${temp_slug}.md"

[../Retornar](/blog/)

# $temp_title
Data: $(date "+%d de %B de %Y às %R")

Por: $AUTHOR

---

Escreva sua postagem aqui.

TEMPLATE
}

function BLOG_MENU() {
    clear
    echo "===================================="
    echo "       BLOG MANAGER - ShellPress"
    echo "===================================="
    echo
    echo " [1] 📝 Criar novo post"
    echo " [2] 🚀 Publicar draft"
    echo " [3] ❌ Sair"
    echo

    read -rp "Selecione uma opção: " choice
    case "$choice" in
        1) NEW_POST ;;
        2) PUBLISH_POST ;;
        3) echo "Saindo..."; exit 0 ;;
        *) echo "Opção inválida. Tente novamente."; sleep 1; BLOG_MENU ;;
    esac
}

function NEW_POST()
{
    read -rp "Titulo do Post: " title
    if [[ -z "$title" ]]; then
        echo "Necessita de um titulo."
        NEW_POST
    fi

    # Tudo em upper.
    NEW_POST_TEMPLATE "${title^^}"

    # Vamos abrir a postagem em draft.
    "$EDITOR"  "${DRAFT_DIR}/${temp_slug}.md"

    read -rp $'\n[ENTER PARA CONTINUAR]'
    BLOG_MENU
}

function PUBLISH_POST()
{
    # Exibindo todos os posts em Draft
    echo
    echo "====================================="
    echo " Postagens em Draft:"
    echo "====================================="
    echo

    drafts=() # Inicializando array.
    counter=1

    for draft_post in "${DRAFT_DIR}"/*.md; do
        # Armazenar o caminho dos drafts e exibir com número
        drafts+=("$draft_post")

        # Pegando o titulo da postagem para exibição.
        post_name="$(grep -m 1 "^#" "$draft_post" | sed 's|^#||')"

        echo " [$counter] - $post_name"
        ((counter++))
    done

    if [[ "${#drafts[@]}" -eq 0 ]]; then
        echo "Nenhuma postagem em draft para publicar!"
        return
    fi

    # Solicitar ao usuário para selecionar um post
    read -rp $'\nDigite o número do post que deseja publicar: ' choice

    #############################################################
    # Vamos já montar a lista de variaveis que serão utilizadas
    # ao longo do programa. Todos sem caminho absoluto!
    #############################################################
    # Original do loop.
    selected_post="${drafts[$((choice - 1))]}"

    export selected_post_path="$(basename "$selected_post")"
    export selected_post_md="${selected_post_path}"
    export selected_post_html="${selected_post_path%.md}.html"
    export selected_post_title=$(grep -m 1 "^#" "${DRAFT_DIR}/$selected_post_path" | sed 's|^#||')

    echo
    echo "##############################################################"
    echo " Publicando: $(basename "$selected_post_path")"
    echo "##############################################################"
    echo

    # Verifique se o diretório public/blog existe.
    if [[ ! -d "$OUT_DIR" ]]; then
        mkdir -v "$OUT_DIR"
    fi

    #####################################
    # Convertendo markdown para HTML.
    #####################################
    html_file_temp=$(mktemp)
    markdown "${DRAFT_DIR}/$selected_post_md" > "$html_file_temp"

    # Criando postagem final com .html já estruturado
    # em seu devido destino
    {
        HEADER
        cat "$html_file_temp"
        FOOTER
    } > "${OUT_DIR}/selected_post_html"

    # Criando uma lista (tipo mapa) para inserir os posts
    # Linha a linha.
    blog_list_file="${OUT_DIR}/.post-list.html"

    # Cria arquivo se não existir
    [[ ! -f "$blog_list_file" ]] && touch "$blog_list_file"

    # Gerando a entrada html para enviar para a lista (mapa)
    new_entry="<li><a href='$selected_post_html'>[$(date '+%d de %B de %Y')] - $selected_post_title</a></li>"

    # Atualiza .post-list.html (se o post ainda não estiver listado)
    if ! grep -q "$selected_post_title" "$blog_list_file"; then
        tmp_list=$(mktemp)
        {
            echo "$new_entry"
            cat "$blog_list_file"
        } > "$tmp_list"
        mv -v "$tmp_list" "$blog_list_file"
    else
        echo "----> Post $selected_post_title já esta em $blog_list_file."
    fi

    #####################################
    # Criação do blog/index.html
    # já estruturado em public/
    #####################################
    # Enviando para um arquivo temporario já estruturado
    # com todas entradas.
    tmp_file=$(mktemp)

    {
        HEADER
        MENU
        echo '<div class="terminal-text">'
        echo '<h2>root@slackjeff: Blog/</h2>'
        echo '</div>'
        echo '<a href="/blog/rss.xml"><i class="fa-solid fa-square-rss"></i></a>'
        echo "<ul>"
        cat "$blog_list_file"
        echo "</ul>"
        FOOTER
    } > "$tmp_file"

    # Movendo arquivo temporário para arquivo final em public/
    mv -v "$tmp_file" "${OUT_DIR}/index.html"
    echo "✅ Post adicionado à lista do blog."

    ###################
    # Gerando RSS
    ###################
    INSERT_POST_RSS "${selected_post_md}"

    # Removendo draft post
    rm -iv "$draft_post"

} # Fecha Funcao

# Template RSS.
function INIT_XML()
{
    cat <<EOF > "${OUT_DIR}/rss.xml"
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
  <channel>
    <title>Slackjeff Blog</title>
    <link>https://slackjeff.com.br/blog/</link>
    <description>Últimas postagens</description>
    <language>pt-br</language>
  </channel>
</rss>
EOF

} # Fecha INIT_XML

function INSERT_POST_RSS()
{
  local post_md="${1}"
  # Para url.
  local post_slug="$1"
  # Vamos primeiramente pegar do arquivo md o titulo.
  local title_md="$(grep -m1 '^#' "${DRAFT_DIR}/$post_md" | tr -d '#')"
  local desc_md="$(awk '/^---/ {found=1; next} found' "${DRAFT_DIR}/$post_md" | head -n 2 | tr '\n' ' ')"

  echo "✅ Inserindo postagem no feed RSS."

  xmlstarlet ed -L \
  -s "/rss/channel" -t elem -n item -v "" \
  -s "/rss/channel/item[last()]" -t elem -n title -v "$title_md" \
  -s "/rss/channel/item[last()]" -t elem -n link -v "https://slackjeff.com.br/blog/$post_slug" \
  -s "/rss/channel/item[last()]" -t elem -n description -v "$desc_md" \
  -s "/rss/channel/item[last()]" -t elem -n pubDate -v "$(date)" \
  "${OUT_DIR}/rss.xml"
}

# Se não existir, inicie o template rss.
if [[ ! -f "${OUT_DIR}/rss.xml" ]]; then
    INIT_XML
fi

BLOG_MENU
