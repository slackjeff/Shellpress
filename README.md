# ShellPress

SHellpress é um gerador de sites estáticos escrito em Shell Script, simples e eficiente. Ele suporta módulos para:

* Gerar páginas estáticas personalizadas,
* Incorporar automaticamente N vídeos do seu canal,
* Gerenciar um sistema completo de blog com posts organizados.

Ideal para quem quer um site rápido, leve e fácil de manter, sem depender de plataformas complexas.

## Estrutura

| Diretório/Arquivo   | Descrição                                           |
|--------------------|----------------------------------------------------|
| `blog/`            | Conteúdo e arquivos do blog (posts em Markdown)    |
| `pages/`           | Páginas em HTML estrutural do seu site.    |
| `lib/`             | Bibliotecas e scripts auxiliares do Shellpress     |
| `public/`          | Site estático gerado pronto para deploy (HTML, CSS) |
| `build-blog.sh`    | Script para construir o blog                        |
| `fetch-youtube-videos.sh` | Script para fazer fetch de últimos n videos de um canal no youtube |
| `shellpress.sh`    | Script principal do SHellpress                      |
| `shellpress.config`| Arquivo de configuração |


## Melhorias

Melhorias são sempre bem vindas, o que pode ser melhorado:

* Deixar mais modular possivel.
* Deixar cada função independente para se caso ser necessário executar com o cron.
* Ter um arquivo CSS (padrão)
* Melhorar a parte de argumentos do Shellpress.sh (Nomes principalmente)

## Argumentos

| Opção              | Descrição                                                        |
|--------------------|-----------------------------------------------------------------|
| `--help`           | Exibe a ajuda e lista todas as opções disponíveis               |
| `--generate-videos` | Gera a página com os últimos vídeos (últimos 'x') do canal YouTube |
| `--blog`           | Abre o gerenciador do blog para escrita e publicação de posts   |
| `--generate-all`   | Gera o site estático completo (exceto módulos)       |


## Usado por

Esse projeto é usado pelas seguintes sites:

- [slackjeff.com.br](https://slackjeff.com.br)

