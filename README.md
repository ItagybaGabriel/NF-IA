# Processamento de Cupons Fiscais
Descrição do Projeto
Este projeto é uma aplicação que processa imagens de cupons fiscais para extrair informações relevantes, como o valor total e o CNPJ da empresa emissora. O objetivo é facilitar a extração e a verificação dessas informações de forma automatizada, utilizando técnicas de visão computacional e reconhecimento óptico de caracteres (OCR).

## Desenvolvimento
O projeto foi desenvolvido utilizando uma estrutura modular, com diferentes componentes para lidar com a leitura de imagens, processamento de dados e integração via API. A aplicação é composta por um backend e um frontend para fornecer uma interface ao usuário.

## Backend:

- Implementado usando Flask.
- Recebe imagens de cupons fiscais em formato base64.
- Processa a imagem para extrair o valor total e o CNPJ da empresa.
- Retorna os dados extraídos em formato JSON.

### Processamento de Imagens:

- Converte a imagem base64 em um formato utilizável.
- Realiza a transformação de perspectiva para corrigir a orientação das imagens dos cupons fiscais antes do processamento OCR.
- Aplica técnicas de OCR para extrair texto.
- Utiliza expressões regulares para encontrar o valor total e o CNPJ no texto extraído.

## Frontend
O front-end do projeto foi desenvolvido utilizando Flutter, proporcionando uma interface de usuário para interagir com a API.

- Tela Principal:
Permite ao usuário escanear cupons fiscais usando a câmera do dispositivo ou selecionar uma imagem salva na galeria. As informações são salvas na memória do aparalho ao extrair as informações de um cupom fiscal.

- Tela de Dashboard:
Exibe um resumo das informações salvas, como um gráfico, o valor total das notas já escaneadas, e uma lista com o histórico de cupons (com a opção de excluir algum cupom fiscal indesejado).

## Principais Tecnologias Envolvidas
### Linguagens de Programação:

- Python: Linguagem utilizada para o desenvolvimento do backend.
- Dart: Linguagem utilizada para o desenvolvimento do frontend com Flutter.

### Frameworks e Bibliotecas:

- Flask: Usado para criar a API REST no backend.
- OpenCV: Usado para processamento de imagens e transformações de perspectiva.
- Pytesseract: Utilizado para realizar o OCR e extrair texto das imagens.
- NumPy: Usado para manipulação de arrays e cálculos matemáticos.
- Matplotlib: Utilizado para visualização de imagens transformadas.
- Flutter: Usado para o desenvolvimento do front-end.
- http: Biblioteca do Dart utilizada para fazer requisições HTTP.

## Instruções de Instalação e Execução:

### Backend
- Clone o repositório do backend:
```
git clone https://github.com/isaasc/cv-invoice.git
cd <NOME_DO_DIRETORIO_BACKEND>
```
- Instale as dependências:
```
pip install -r requirements.txt
```
- Instale o Tesseract seguindo as instruções [neste link](https://github.com/UB-Mannheim/tesseract/wiki).
- Adicione o caminho do Tesseract ao PATH do sistema no Windows:
  Em "Variáveis do sistema", encontre a variável "Path" e clique em "Editar".
  Adicione o caminho onde o Tesseract foi instalado (por exemplo, C:\Program Files\Tesseract-OCR).
  
- Execute a API:
```
python api.py
```
### Frontend
- Clone o repositório do frontend:
```
git clone https://github.com/ItagybaGabriel/NF-IA.git
cd <NOME_DO_DIRETORIO_FRONTEND>
```

- Instale as dependências do Flutter:
```
flutter pub get
```
- Execute o aplicativo Flutter:
```
flutter run
```
O aplicativo será executado em um emulador ou dispositivo físico conectado.










