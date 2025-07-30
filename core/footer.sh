#!/bin/sh
#####################################################################
# Gerador do Rodapé.
#####################################################################

cat <<EOF
<footer style="padding:20px; text-align:center; color: white; font-family: monospace;">
  <p>&copy; 2005 ~ 2025 Slackjeff. Todos os direitos reservados.</p>

  <p>Me acompanhe nas redes:</p>
  <a href="https://mastodon.social/@Theslackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-mastodon" style="font-size:36px;"></i>
  </a>
  <a href="https://github.com/slackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-github" style="font-size:36px;"></i>
  </a>
  <a href="https://www.youtube.com/slackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-youtube" style="font-size:36px;"></i>
  </a>
  <a href="https://www.linkedin.com/in/oslackjeff/" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-linkedin-in" style="font-size:36px;"></i>
  </a>

  <p class="powered-tag">Gerado com <strong>ShellPress</strong></p>
</footer>
EOF
