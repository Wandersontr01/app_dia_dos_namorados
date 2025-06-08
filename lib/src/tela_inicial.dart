import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nosso_cantinho/src/desafios/desafio_senha_dialog.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final List<String> imagens = [
    'assets/images/foto1.jpg',
    'assets/images/foto2.jpg',
    'assets/images/foto3.jpg',
    'assets/images/foto4.jpg',
  ];

  final PageController _controller = PageController();
  int _paginaAtual = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_paginaAtual < imagens.length - 1) {
        _paginaAtual++;
      } else {
        _paginaAtual = 0;
      }

      _controller.animateToPage(
        _paginaAtual,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrossel de fundo com auto-scroll
          PageView.builder(
            controller: _controller,
            itemCount: imagens.length,
            itemBuilder: (context, index) {
              return Image.asset(
                imagens[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),

          // Gradiente escuro para leitura
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Conteúdo romântico no centro
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Feliz Dia dos Namorados 💖',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      mostrarDesafioSenha(context);
                    },
                    child: const Text(
                      'Entrar no nosso mundinho 💫',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
