// lib/widgets/support_button.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportButton extends StatefulWidget {
  const SupportButton({Key? key}) : super(key: key);

  @override
  _SupportButtonState createState() => _SupportButtonState();
}

class _SupportButtonState extends State<SupportButton>
    with SingleTickerProviderStateMixin {
  static const String _url = 'https://cafecito.app/dolarboom';

  // Controlador de animación para la gota
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configuración del controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Repetir la animación hacia adelante y hacia atrás

    // Definir la animación de movimiento
    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Método para abrir la URL
  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(_url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Mostrar un SnackBar si no se pudo abrir el enlace
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL, // Toda la card es clickeable
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.98).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Container(
          height: 140, // Aumentar la altura de la card
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Row(
              children: [
                // Texto Informativo con "$ AR$300" destacado y centrado
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Ayúdanos a mantenernos online solo por ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\AR\$300',
                            style: TextStyle(
                              color: Colors.yellow.shade200,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Efecto Gota Animado
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(-_animation.value, 0), // Movimiento hacia la izquierda
                      child: child,
                    );
                  },
                  child: const Icon(
                    Icons.coffee,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'Gota de agua animada',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
