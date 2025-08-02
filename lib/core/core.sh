#******************
# Cabeçalho
#******************
function HEADER()
{
    echo "🔧 [build] Gerando header: início da estrutura da página" >&2
    cat <<EOF
<!--------------------
Gerado com ShellPress
-------->

<!DOCTYPE html>
<html lang=$LANG>
<head>
  <title>Slackjeff</title>
  <meta charset="UTF-8">
  <meta name="description" content="Site pessoal do Slackjeff.">
  <meta name="keywords" content="slackjeff,linux,shell script,open source,software livre'">
  <meta name="author" content="Jefferson Carneiro">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="/style.css">
  <link rel="icon" href="/slackjeff-favicon.png" type="image/png">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

EOF

} # Fecha HEADER


#******************
# Rodapé
#******************
function FOOTER()
{
    echo "🧱 [build] Adicionando footer: fechamento da estrutura da página" >&2

    cat <<EOF
<footer style="padding:20px; text-align:center; color: white; font-family: monospace;">
  <p>&copy; 2005 ~ 2025 Slackjeff. Todos os direitos reservados.</p>

  <p>Me acompanhe nas redes:</p>
  <a href="https://mastodon.social/@Theslackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-mastodon" style="font-size:36px;"></i>
  </a>
  <a href="https://github.com/slackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color:#0eca7f;text-decoration:none;">
    <i class="fa-brands fa-github" style="font-size:36px;"></i>
  </a>
  <a href="https://www.youtube.com/slackjeff" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-youtube" style="font-size:36px;"></i>
  </a>
  <a href="https://www.linkedin.com/in/oslackjeff/" target="_blank" rel="noopener noreferrer" style="margin: 0 15px; color: #0eca7f;text-decoration:none;">
    <i class="fa-brands fa-linkedin-in" style="font-size:36px;"></i>
  </a>

  <p class="powered-tag">Gerado com <strong><a href="https://github.com/slackjeff/Shellpress">ShellPress</a></strong></p>
</footer>
EOF

} # Fecha FOOTER


#******************
# Navbar (menu)
#******************
function MENU()
{
    echo "📂 [build] Inserindo componente de navegação (menu)" >&2

    cat <<EOF
<header class="topbar">
  <div id="logo">
    <h1># Slackjeff</h1>
  </div>
  <nav class="menu">
    <ul>
      <li><a href="/">Início</a></li>
      <li><a href="/blog/">Blog</a></li>
      <li><a href="https://safearmor.com.br/">Serviços</a></li>
      <li><a href="/cursos/">Cursos</a></li>
      <li><a href="/area-do-aluno/">Área do Aluno</a></li>
      <li><a href="/videos/">Videos</a></li>
      <li><a href="/contato/">Contato</a></li>
    </ul>
  </nav>
</header>

EOF

} # Fecha MENU
