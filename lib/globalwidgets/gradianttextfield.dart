import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradientTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const GradientTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definimos el degradado que deseamos aplicar
    final Gradient gradient = LinearGradient(
      colors: [Colors.blueAccent, Colors.purpleAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: gradient, // Aplicamos el degradado al contenedor
        borderRadius: BorderRadius.circular(20), // Bordes redondeados
      ),
      padding: const EdgeInsets.all(2), // Grosor del borde
      child: Container(
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(18), // Bordes ligeramente más pequeños
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Calcular compra',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none, // Eliminamos el borde por defecto
            ),
            prefixIcon: const Icon(Icons.attach_money),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20.0, // Aumentamos el padding vertical para hacer el campo más alto
              horizontal: 16.0,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
