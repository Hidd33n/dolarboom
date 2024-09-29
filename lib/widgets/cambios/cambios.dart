import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CambiosWidget extends StatefulWidget {
  final Map<String, dynamic> dolares;

  CambiosWidget({required this.dolares});

  @override
  _CambiosWidgetState createState() => _CambiosWidgetState();
}

class _CambiosWidgetState extends State<CambiosWidget> {
  TextEditingController _pesosController = TextEditingController();
  double _cantidadPesos = 0.0;

  @override
  Widget build(BuildContext context) {
    final dolarBlue = widget.dolares['Blue']['venta'];
    final dolarOficial = widget.dolares['Oficial']['venta'];
    final dolarTarjeta = widget.dolares['Tarjeta']['venta'];

    // Cálculos para cada tipo de dólar
    final valorBlue = _cantidadPesos / dolarBlue;
    final valorOficial = _cantidadPesos / dolarOficial;
    final valorTarjeta = _cantidadPesos / dolarTarjeta;

    return Padding(
      padding: const EdgeInsets.all(8.0), // Reducimos el padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo para ingresar el valor en pesos
          TextField(
            controller: _pesosController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese la cantidad en pesos',
              hintStyle: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
                fontSize: 12, // Tamaño de la etiqueta reducido
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.green[800]!,
                  width: 1.0, // Grosor del borde reducido
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.green[400]!,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.green[800]!,
                  width: 1.0,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.attach_money,
                color: Colors.green[800],
                size: 20, // Tamaño del icono reducido
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8), // Padding interno reducido
            ),
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 12, // Tamaño del texto reducido
            ),
            onChanged: (value) {
              setState(() {
                _cantidadPesos = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 16),
          // Mostrar los cálculos en tarjetas pequeñas dispuestas horizontalmente
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Tarjeta para Dólar Blue
                _buildDollarCard(
                  color: Colors.blue[50],
                  icon: Icons.attach_money,
                  iconColor: Colors.blue[400],
                  title: 'Blue',
                  value: valorBlue,
                  textColor: Colors.blue[800],
                ),
                const SizedBox(width: 8),
                // Tarjeta para Dólar Oficial
                _buildDollarCard(
                  color: Colors.green[50],
                  icon: Icons.monetization_on,
                  iconColor: Colors.green[400],
                  title: 'Oficial',
                  value: valorOficial,
                  textColor: Colors.green[800],
                ),
                const SizedBox(width: 8),
                // Tarjeta para Dólar Tarjeta
                _buildDollarCard(
                  color: Colors.red[50],
                  icon: Icons.credit_card,
                  iconColor: Colors.red[400],
                  title: 'Tarjeta',
                  value: valorTarjeta,
                  textColor: Colors.red[800],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDollarCard({
    required Color? color,
    required IconData icon,
    required Color? iconColor,
    required String title,
    required double value,
    required Color? textColor,
  }) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bordes menos redondeados
      ),
      child: Container(
        width: 100, // Ancho fijo para tarjetas pequeñas
        padding: const EdgeInsets.all(8), // Padding reducido
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24, // Tamaño del icono reducido
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14, // Tamaño de fuente reducido
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${value.toStringAsFixed(2)} USD',
              style: GoogleFonts.poppins(
                fontSize: 12, // Tamaño de fuente reducido
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pesosController.dispose();
    super.dispose();
  }
}
