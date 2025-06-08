import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nosso_cantinho/src/tela_final.dart';
import 'package:audioplayers/audioplayers.dart';

class JogoMemoria extends StatefulWidget {
  const JogoMemoria({super.key});

  @override
  State<JogoMemoria> createState() => _JogoMemoriaState();
}

class _JogoMemoriaState extends State<JogoMemoria>
    with TickerProviderStateMixin {
  final List<Map<String, String>> pares = [
    {
      'imagem': 'assets/images/jogo_memoria/foto1.jpg',
      'mensagem': 'Amei passar esses dias com você, meu amor! 💖',
    },
    {
      'imagem': 'assets/images/jogo_memoria/foto2.jpg',
      'mensagem': 'Essa viagem foi incrível ao seu lado! 🌅',
    },
    {
      'imagem': 'assets/images/jogo_memoria/foto3.jpg',
      'mensagem': 'Cumplicidade em uma imagem. Te amo! 🥰',
    },
    {
      'imagem': 'assets/images/jogo_memoria/foto4.jpg',
      'mensagem': 'A pessoa incrível que eu sempre quero ao meu lado! 💞',
    },
    {
      'imagem': 'assets/images/jogo_memoria/foto5.jpg',
      'mensagem': 'Amo nossas brincadeiras e risadas! 😄',
    },
    {
      'imagem': 'assets/images/jogo_memoria/foto6.jpg',
      'mensagem': 'Tenho muito orgulho de você!\n Te amo mais a cada dia! 💘',
    },
  ];

  late List<_Carta> cartas;
  _Carta? primeiraCartaVirada;
  bool bloqueio = false;

  late final AudioPlayer _efeitoVirar;
  late final AudioPlayer _efeitoAplausos;

  @override
  void initState() {
    super.initState();
    // Inicialização dos players
    _efeitoVirar = AudioPlayer();
    _efeitoAplausos = AudioPlayer();
    cartas = [];
    for (var par in pares) {
      cartas.add(_Carta(imagem: par['imagem']!, mensagem: par['mensagem']!));
      cartas.add(_Carta(imagem: par['imagem']!, mensagem: par['mensagem']!));
    }
    cartas.shuffle();
  }

  Future<void> _verificarPar(int index) async {
    if (bloqueio || cartas[index].virada || cartas[index].encontrada) return;

    await _efeitoVirar.play(AssetSource('audios/virar_carta.mp3'));

    setState(() => cartas[index].virada = true);

    if (primeiraCartaVirada == null) {
      primeiraCartaVirada = cartas[index];
    } else {
      bloqueio = true;
      Future.delayed(const Duration(milliseconds: 1200), () async {
        if (primeiraCartaVirada!.imagem == cartas[index].imagem) {
          setState(() {
            primeiraCartaVirada!.encontrada = true;
            cartas[index].encontrada = true;
          });

          final bool terminouJogo = cartas.every((c) => c.encontrada);
          final imagem = cartas[index].imagem;
          final mensagem = cartas[index].mensagem;

          if (terminouJogo) {
            await _efeitoAplausos.setReleaseMode(ReleaseMode.loop);
            await _efeitoAplausos.play(AssetSource('audios/aplausos.mp3'));

            _mostrarAnimacaoComCoracoes(() {
              _mostrarMensagemSurpresa(
                mensagem,
                imagem,
                aoFechar: () async {
                  await _efeitoAplausos.stop();
                  _mostrarMensagemFinal();
                },
              );
            });
          } else {
            _mostrarMensagemSurpresa(mensagem, imagem);
          }
        } else {
          setState(() {
            primeiraCartaVirada!.virada = false;
            cartas[index].virada = false;
          });
        }

        primeiraCartaVirada = null;
        bloqueio = false;
      });
    }
  }

  void _mostrarMensagemSurpresa(
    String mensagem,
    String imagem, {
    VoidCallback? aoFechar,
  }) {
    showDialog(
      context: context,

      builder:
          (_) => AlertDialog(
            title: const Text('Voce encontrou um par! 💖'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagem, height: 100),
                const SizedBox(height: 12),
                Text(mensagem),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (aoFechar != null) {
                    Future.delayed(const Duration(milliseconds: 100), aoFechar);
                  }
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
    );
  }

  void _mostrarMensagemFinal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        // Iniciar áudio de fundo AQUI, antes da tela final
        TelaFinal.iniciarAudio(); // chamada estática

        return AlertDialog(
          title: const Text('Você chegou até aqui 💘'),
          content: const Text(
            'Você acertou todos os pares... e também acertou meu coração ❤️\n\n'
            'Te amo mais do que palavras podem dizer. Obrigado por ser meu par em tudo!\n\n'
            'Quero viver muitos e muitos momentos ao seu lado, porque cada instante contigo é especial.\n'
            'Tenho tanto orgulho de quem você é, uma mulher forte, carinhosa, inteligente e absolutamente incrível.\n'
            'Sou grato todos os dias por ter você comigo. Te amo infinitamente! 💘',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TelaFinal()),
                  );
                });
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarAnimacaoComCoracoes(VoidCallback aoTerminar) async {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder:
          (context) => Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: List.generate(
                  12,
                  (index) => _CoracaoAnimado(
                    delay: Duration(milliseconds: index * 300),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);

    // 🔁 Aplausos em loop
    await _efeitoAplausos.setReleaseMode(ReleaseMode.loop);
    await _efeitoAplausos.play(AssetSource('audios/aplausos.mp3'));

    // ⚠️ Remoção do overlay será feita manualmente
    aoTerminar.call(); // animações continuam até você parar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Jogo da Memoria 💝'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: cartas.length,
          itemBuilder: (context, index) {
            final carta = cartas[index];
            return GestureDetector(
              onTap: () => _verificarPar(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    carta.encontrada || carta.virada
                        ? carta.imagem
                        : 'assets/images/carta_verso.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Carta {
  final String imagem;
  final String mensagem;
  bool virada = false;
  bool encontrada = false;

  _Carta({required this.imagem, required this.mensagem});
}

class _CoracaoAnimado extends StatefulWidget {
  final Duration delay;

  const _CoracaoAnimado({required this.delay});

  @override
  State<_CoracaoAnimado> createState() => _CoracaoAnimadoState();
}

class _CoracaoAnimadoState extends State<_CoracaoAnimado>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final double _randomLeft;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });

    _randomLeft = Random().nextDouble();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animation,

      builder:
          (_, child) => Positioned(
            bottom: MediaQuery.of(context).size.height * _animation.value,
            left: screenWidth * _randomLeft,
            child: Opacity(
              opacity: _animation.value,
              child: const Icon(Icons.favorite, color: Colors.pink, size: 32),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
