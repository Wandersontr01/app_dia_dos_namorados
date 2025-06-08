<h1 align="center"> 💖 Nosso Cantinho — Aplicativo Flutter </h1>

> Um presente digital interativo, desenvolvido com carinho para proporcionar uma experiência única em datas especiais como o Dia dos Namorados.

---

## 📝 Descrição

**Nosso Cantinho** é um aplicativo Flutter que combina um jogo da memória, mensagens emocionantes, efeitos sonoros e animações com corações e carrossel de fotos. A experiência é personalizada para criar um momento memorável entre duas pessoas.

⚠️ Este repositório utiliza **imagens de exemplo** localizadas na pasta `assets/images/`. Para personalizar com suas próprias fotos, basta substituí-las pelos arquivos de mesmo nome ou atualizar os caminhos no código (`jogo_memoria.dart` e `tela_final.dart`).

---

## 🎯 Funcionalidades

- 🃏 Jogo da memória com 6 pares únicos (imagem + mensagem personalizada)
- 🔊 Sons ao virar cartas e ao finalizar o jogo
- ❤️ Animação de corações flutuantes na finalização
- 📸 Carrossel de fotos na tela final com música de fundo
- 🎁 Mensagem final com declaração de amor
- 📱 Compatível com dispositivos Android (arquivo .apk gerado)

---

## 🖼️ Capturas de Tela

<table>
  <tr>
    <th>Tela de login com dicas</th>
    <th>Jogo da Memória</th>
    <th>Pop-up de Par Encontrado</th>
    <th>Tela Final com Corações</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/af164346-e6d4-4e97-967f-fd6073207a70" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/531dbba5-1973-45cb-8cc7-89d858e816e2" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/ced95117-b7fc-4fde-a9da-d7d5329c55cd" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/59ef45e3-ce3b-4d8d-8830-6423a005bdce" width="250"/></td>
  </tr>
</table>


---

## 🗂️ Substituição de Imagens

### Jogo da Memória

- Caminho: `assets/images/jogo_memoria/`
- Arquivos esperados: `foto1.jpg` até `foto6.jpg`

### Carrossel da Tela Final

- Caminho: `assets/images/`
- Arquivos esperados: `foto1.jpg`, `foto2.jpg`, `foto3.jpg`, `foto4.jpg`

📌 Para personalizar o app com suas próprias imagens:
1. Substitua os arquivos existentes pelas suas fotos.
2. Mantenha os mesmos nomes dos arquivos originais **ou** atualize os caminhos no código Dart.

---

## ▶️ Como Executar

### Pré-requisitos

- Flutter instalado [(guia oficial)](https://docs.flutter.dev/get-started/install)
- Emulador Android ou dispositivo físico

### Passos

```bash
git clone https://github.com/SEU_USUARIO/nosso_cantinho.git
cd nosso_cantinho
flutter pub get
flutter run
```

---

## 📦 Gerar APK

Para gerar o arquivo `.apk` de produção:

```bash
flutter build apk --release
```

O arquivo será gerado em:

```
build/app/outputs/flutter-apk/app-release.apk
```

Você pode fazer o upload em uma plataforma como OneDrive ou Google Drive e gerar um QR Code com o link.

---

## 🧠 Estrutura do Projeto

```
lib/
├── main.dart
└── src/
    ├── tela_inicial.dart
    ├── jogo_memoria.dart
    └── tela_final.dart

assets/
├── images/
│   ├── jogo_memoria/
│   │   └── foto1.jpg ... foto6.jpg
│   └── foto1.jpg ... foto4.jpg
├── audios/
│   ├── virar_carta.mp3
│   ├── aplausos.mp3
│   └── audio_fundo_final.mp3

docs/
├── jogo_memoria.png
├── popup_par.png
└── tela_final.png
```

---

## :pushpin: Desenvolvedor:
| <img src="https://avatars.githubusercontent.com/u/105672201?v=4" width=115><br><sub>Wanderson Franca</sub><br> <sub> Consultor SAP ABAP/CPI/CI <br></sub><br> [![Linkedin: Wanderson](https://img.shields.io/badge/-Linkedin-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/wandersonfg/)  [![Hotmail: Wanderson](https://img.shields.io/badge/-Email-blue?%23E4405F?style=flat-square&logo=microsoftoutlook&logoColor=white)](mailto:wanderson.f.g@hotmail.com) |
| :---: |

Contribuições, ideias ou feedbacks são bem-vindos.

---

> _"Você acertou todos os pares... e também acertou meu coração ❤️  
Te amo mais do que palavras podem dizer. Obrigado por ser meu par em tudo!  
Quero viver muitos e muitos momentos ao seu lado, porque cada instante contigo é especial.  
Tenho tanto orgulho de quem você é, uma mulher forte, carinhosa, inteligente e absolutamente incrível.  
Sou grato todos os dias por ter você comigo. Te amo infinitamente!"_ 💘
