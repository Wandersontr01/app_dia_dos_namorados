import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'tela_inicial.dart';

class TelaFinal extends StatefulWidget {
  const TelaFinal({super.key});

  @override
  State<TelaFinal> createState() => _TelaFinalState();

  static Future<void> iniciarAudio() async {
    if (!_TelaFinalState._audioJaTocando) {
      _TelaFinalState._audioJaTocando = true;
      await _TelaFinalState._audioFundo.setReleaseMode(ReleaseMode.loop);
      await _TelaFinalState._audioFundo.play(
        AssetSource('audios/audio_fundo_final.mp3'),
      );
    }
  }
}

class _TelaFinalState extends State<TelaFinal>
    with SingleTickerProviderStateMixin {
  final List<String> imagens = [
    'assets/images/foto1.jpg',
    'assets/images/foto2.jpg',
    'assets/images/foto3.jpg',
    'assets/images/foto4.jpg',
  ];

  final PageController _controller = PageController();
  int _paginaAtual = 0;
  Timer? _timer;

  late List<_CoracaoAnimado> coracoes;
  late Timer coracaoTimer;

  static final AudioPlayer _audioFundo = AudioPlayer();
  static bool _audioJaTocando = false;

  @override
  void initState() {
    super.initState();
    _iniciarCarrossel();
    _iniciarCoracoes();
  }

  void _iniciarCarrossel() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _paginaAtual = (_paginaAtual + 1) % imagens.length;
        _controller.animateToPage(
          _paginaAtual,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void _iniciarCoracoes() {
    final random = Random();
    coracoes = List.generate(15, (_) => _CoracaoAnimado(random));

    coracaoTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      setState(() {
        for (final coracao in coracoes) {
          coracao.atualizar(context);
        }
      });
    });
  }

  static Future<void> _pararAudio() async {
    await _audioFundo.stop();
    _audioJaTocando = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    coracaoTimer.cancel();
    _pararAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrossel de imagens
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

          // Gradiente escuro
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Corações animados
          ...coracoes.map(
            (c) => Positioned(
              top: c.y,
              left: c.x,
              child: Icon(
                Icons.favorite,
                color: Colors.pinkAccent.withOpacity(0.8),
                size: c.tamanho,
              ),
            ),
          ),

          // Texto e botões
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
                  ElevatedButton.icon(
                    onPressed: () {
                      _pararAudio();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const TelaInicial()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar para o Início'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _pararAudio();
                      SystemNavigator.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text('Fechar Aplicativo'),
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

class _CoracaoAnimado {
  double x;
  double y;
  final double velocidade;
  final double tamanho;
  final Random random = Random();

  _CoracaoAnimado(Random rng)
    : x = rng.nextDouble() * 400,
      y = 600 + rng.nextDouble() * 400,
      velocidade = 0.5 + rng.nextDouble() * 1.5,
      tamanho = 20 + rng.nextDouble() * 20;

  void atualizar(BuildContext context) {
    y -= velocidade;
    if (y < -50) {
      y = MediaQuery.of(context).size.height + random.nextDouble() * 100;
      x = random.nextDouble() * MediaQuery.of(context).size.width;
    }
  }
}
