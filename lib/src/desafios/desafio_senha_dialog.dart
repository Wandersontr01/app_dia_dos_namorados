import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nosso_cantinho/src/jogo_memoria.dart';

void mostrarDesafioSenha(BuildContext rootContext) {
  final TextEditingController controller = TextEditingController();
  final String senhaCorreta = "amor2019";
  int tentativas = 0;
  String mensagemErro = '';
  List<String> mensagensTristes = [
    'Ai não... errou 😢',
    'Hmm... quase, mas não 💔',
    'Isso partiu meu coração um pouquinho 💔',
    'Vamos tentar de novo, amor? 😞',
    'Errar faz parte... mas tente lembrar! 💭',
  ];

  final List<String> dicas = [
    'É uma palavra que resume tudo o que sinto por você ❤️',
    'Tem 4 letras... mas carrega o mundo 🌍',
    'Junto com o ano em que tudo começou pra valer ✨',
  ];

  bool mostrarDica1 = false;
  bool mostrarDica2 = false;
  bool mostrarDica3 = false;

  showDialog(
    context: rootContext,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          title: const Text('Opa, calma lá... 😉'),
          content: const Text(
            'Antes de continuar, vamos ver se você nos conhece mesmo...',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o primeiro dialog

                showDialog(
                  context: rootContext,
                  barrierDismissible: false,
                  builder:
                      (contextSenha) => StatefulBuilder(
                        builder:
                            (contextSenha, setState) => AlertDialog(
                              title: const Text('Descubra a senha! hihihi 🔐'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: 'Digite a senha',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (controller.text
                                              .trim()
                                              .toLowerCase() ==
                                          senhaCorreta.toLowerCase()) {
                                        Navigator.pop(
                                          contextSenha,
                                        ); // Fecha campo de senha

                                        showDialog(
                                          context: rootContext,
                                          barrierDismissible: false,
                                          builder:
                                              (_) => AlertDialog(
                                                title: const Text(
                                                  'Acertei? 😍',
                                                ),
                                                content: const Text(
                                                  'Sabia que você me conhece como ninguém 💖\n\nAgora sim, bora pro nosso joguinho!',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        rootContext,
                                                      ); // Fecha mensagem

                                                      Future.delayed(
                                                        Duration.zero,
                                                        () {
                                                          Navigator.of(
                                                            rootContext,
                                                          ).push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (_) =>
                                                                      const JogoMemoria(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: const Text(
                                                      'Vamos lá!',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      } else {
                                        tentativas++;
                                        controller.clear();
                                        setState(() {
                                          mensagemErro =
                                              mensagensTristes[Random().nextInt(
                                                mensagensTristes.length,
                                              )];
                                          if (tentativas >= 2) {
                                            mostrarDica1 = true;
                                          }
                                          if (tentativas >= 3) {
                                            mostrarDica2 = true;
                                          }
                                          if (tentativas >= 4) {
                                            mostrarDica3 = true;
                                          }
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 14,
                                      ),
                                    ),
                                    child: const Text(
                                      'Tentar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  if (mensagemErro.isNotEmpty) ...[
                                    const SizedBox(height: 10),
                                    Text(
                                      mensagemErro,
                                      style: const TextStyle(color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  const SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed:
                                            mostrarDica1
                                                ? () => ScaffoldMessenger.of(
                                                  rootContext,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(dicas[0]),
                                                  ),
                                                )
                                                : null,
                                        child: const Text('Dica 1'),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            mostrarDica2
                                                ? () => ScaffoldMessenger.of(
                                                  rootContext,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(dicas[1]),
                                                  ),
                                                )
                                                : null,
                                        child: const Text('Dica 2'),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            mostrarDica3
                                                ? () => ScaffoldMessenger.of(
                                                  rootContext,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(dicas[2]),
                                                  ),
                                                )
                                                : null,
                                        child: const Text('Dica 3'),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                        contextSenha,
                                      ); // Fecha o pop-up da senha
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ),
                      ),
                );
              },
              child: const Text('Vamos começar'),
            ),
          ],
        ),
  );
}
