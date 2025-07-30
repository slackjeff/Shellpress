#!/bin/sh
#####################################################################
# Gerador do cabeçalho
#####################################################################

cat <<EOF
<!--------------------
Gerado com ShellPress
-------->

<!DOCTYPE html>
<html lang=$LANG>
<head>
  <title>$TITLE</title>
  <meta charset="$CHARSET">
  <meta name="description" content="$DESCRIPTION">
  <meta name="keywords" content="$KEYWORDS">
  <meta name="author" content="$AUTHOR">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="style.css">
  <link rel="icon" href="slackjeff-favicon.png" type="image/x-icon">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

EOF
