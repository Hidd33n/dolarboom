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

    return Column(
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
      fontSize: 14, // Reducimos el tamaño de la etiqueta
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // Bordes un poco menos redondeados
      borderSide: BorderSide(
        color: Colors.green[800]!, 
        width: 1.5, // Reducimos el grosor del borde
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.green[400]!, 
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.green[800]!, 
        width: 1.5,
      ),
    ),
    filled: true,
    fillColor: Colors.grey[200],
    prefixIcon: Icon(
      Icons.attach_money, 
      color: Colors.green[800],
      size: 20, // Reducimos el tamaño del ícono
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Ajustamos el padding interno
  ),
  style: GoogleFonts.poppins(
    color: Colors.black87,
    fontSize: 14, // Reducimos el tamaño del texto ingresado
  ),
  onChanged: (value) {
    setState(() {
      _cantidadPesos = double.tryParse(value) ?? 0.0;
    });
  },
),
        const SizedBox(height: 16),
        // Mostrar los cálculos en una fila de textos
        Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Blue Dollar
    Expanded(
      child: Column(
        children: [
          // Icono y Nombre del dólar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money, // Icono de dólar
                color: Colors.blue[400], // Color azul para el dolar Blue
              ),
              const SizedBox(width: 8),
              Text(
                'Blue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Valor calculado
          Text(
            '${valorBlue.toStringAsFixed(2)} USD',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),

    // Oficial Dollar
    Expanded(
      child: Column(
        children: [
          // Icono y Nombre del dólar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on, // Icono de monetización para el oficial
                color: Colors.green[400], // Color verde para el dolar Oficial
              ),
              const SizedBox(width: 8),
              Text(
                'Oficial',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Valor calculado
          Text(
            '${valorOficial.toStringAsFixed(2)} USD',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),

    // Tarjeta Dollar
    Expanded(
      child: Column(
        children: [
          // Icono y Nombre del dólar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card, // Icono de tarjeta de crédito para el dólar tarjeta
                color: Colors.red[400], // Color rojo para el dolar Tarjeta
              ),
              const SizedBox(width: 8),
              Text(
                'Tarjeta',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Valor calculado
          Text(
            '${valorTarjeta.toStringAsFixed(2)} USD',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  ],
)

      ],
    );
  }

  @override
  void dispose() {
    _pesosController.dispose();
    super.dispose();
  }
}
