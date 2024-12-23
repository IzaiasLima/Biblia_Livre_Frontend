# Frontend da Bíblia Livre

Este projeto visa fornecer um aplicativo para celulares (inicialmente para Android) com a tradução da bíblia em português do Brasil, na versão Bíblia Livre. A **Bíblia Livre (BLIVRE)**  é um projeto de tradução das Sagradas Escrituras em linguagem atualizada. Entre as versões modernas da bíblia, esta é a única que conheço que distribui sua versão brasileira sob licença livre, a Licença Creative Commons Atribuição 3.0 Brasil. A página principal do projeto é  [https://sites.google.com/site/biblialivre/](https://sites.google.com/site/biblialivre/). O repositório contendo os arquivos-fonte da tradução pode ser acessado aqui: [https://github.com/blivre/BibliaLivre](https://github.com/blivre/BibliaLivre).

![Screenshot](assets/images/screenshots.png)

**Lista de recursos:**
- interface simplificada
- uso off-line, sem necessidade de internet
- aplicativo gratuito, sem exibição de anúcios
- busca por uma ou mais palavras
- opção de salvar e remover versículos favoritos
- lista dos 200 versículos mais conhecidos, na ordem em que aparecem na bíblia
- exibição dos livros em ordem alfabética (opção extra), além da ordem tradicional do Antigo e do Novo Testamento
- exibição do capítulo correspondente, clicando no versículo (na busca ou nos favoritos)
- registro do último capítulo acessado, para facilitar a continuidade da última leitura.

### Não somos os tradutores

Não somos os resposáveis pelo projeto de tradução da Bíblia Livre, aqui mencionado. Apenas desenvolvemos este frontend para essa versão da Palavra de Deus. Neste aplicativo estamos usando o arquivo fornecido pelo projeto de tradução no formato *mybible* para o aplicativo MySword para celulares. A versão do arquivo usada neste projeto pode estar desatualizada em relação à última versão disponibilizada pelo projeto de tradução.

Mantivemos a versão baseada no 'Texto Crítico' (revisão 2018.2.0, liberado em 25.02.2018) porém sem exibir as variantes, e com alguns acréscimos vindos do 'Texto Recebido', com vistas a proporcionar maior fluidez na leitura.

As variantes ainda serão exibidas na pesquisa por palavra, visando facilitar a busca, aumentando as chances do versículo ser localizado, visto que o termo informado pelo leitor pode ser justamente uma dessas variantes. 


## Sobre este aplicativo

Este aplicativo é um projeto simples, usado como aprendizado na linguagem Dart, com o framework Flutter. Não tem a pretensão de ser exemplo de melhores práticas em desenvolvimento. O leiaute da tela inicial foi inspirado em um artigo de Jelena Lecic publicado [aqui](https://medium.com/@jelenaaa.lecic/complex-layout-in-flutter-example-8c50e81d5aa9).


### Para saber mais sobre o Flutter

A seguir, algumas fontes de recuros sobre o Flutter:

- [Lab: Escreva seu primeiro aplicativo](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Exemplos úteis em Flutter](https://flutter.dev/docs/cookbook)

Um bom lugar para começar a programar em Flutter é a sua [documentação online](https://flutter.dev/docs), que oferece tutoriais, exemplos, orientações sobre a programação mobile e uma referência completa da API.
