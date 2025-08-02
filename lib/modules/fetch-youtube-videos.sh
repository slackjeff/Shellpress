#!/usr/bin/env bash
#================================================================
# Autor:
#  Jefferson Carneiro <slackjeff@slackjeff.com.br>
#
# Descrição:
#  Módulo para pegar últimos (X) videos no canal slackjeff
#  Pode ser utilizados para outros canais.
#
# Script verificado com ShellCheck (02/08/2025)
# Aprovado com: shellcheck -x fetch-youtube-videos.sh
#================================================================

#==========================
# Configurações
#==========================
CHANNEL_URL="https://www.youtube.com/@slackjeff/videos"
VIDEOS=6  # Quantidade de vídeos a exibir

#==========================
# Início da renderização
#==========================

echo '<div class="terminal-text">'
echo '<h2>root@slackjeff: Últimos Videos/</h2>'
echo '</div>'

echo "<h3>Última Atualização: $(date)</h3>"
echo "<hr/>"

echo '<div class="video-grid">'

curl -s "$CHANNEL_URL" | \
  grep -oP 'watch\?v=\K[\w-]{11}' | \
  awk '!seen[$0]++' | head -n "$VIDEOS" | \
  while read -r video_id; do
    thumbnail_base="https://img.youtube.com/vi/$video_id"
    thumbnail="$thumbnail_base/sddefault.jpg"
    fallback="$thumbnail_base/hqdefault.jpg"

    # Insere div video na página html.
    echo "<a href=\"https://www.youtube.com/watch?v=$video_id\" target=\"_blank\">
            <img src=\"$thumbnail\" alt=\"Vídeo do YouTube\" onerror=\"this.onerror=null;this.src='$fallback';\">
        </a>"
done

echo '</div>'
