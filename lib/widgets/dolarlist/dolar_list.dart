import 'package:dolarcito/screens/detail/dolar_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DolarListWidget extends StatelessWidget {
  final List<dynamic> dolares;

  DolarListWidget({Key? key, required this.dolares}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos columnas
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final dolar = dolares[index];
            return GestureDetector(
              onTap: () {
                // Navegar a la pantalla de detalles al tocar la tarjeta
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DolarDetailScreen(
                      tipoDolar: _getApiName(dolar['nombre']),
                      displayName: dolar['nombre'] == 'Contado con liquidación'
                          ? 'CCL'
                          : dolar['nombre'],
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.white, // Color único para todas las tarjetas
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icono personalizado según el tipo de dólar
                      Icon(
                        _getIcon(dolar['nombre']),
                        color: Colors.green[800], // Color del icono
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dolar['nombre'] == 'Contado con liquidación'
                            ? 'CCL'
                            : dolar['nombre'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87, // Color del texto
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Compra: ${dolar['compra']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54, // Color del texto
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Venta: ${dolar['venta']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54, // Color del texto
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Actualizado: ${DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(dolar['fechaActualizacion']))}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600], // Color del texto
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: dolares.length,
        ),
      ),
    );
  }

  // Función para obtener el icono según el tipo de dólar
  IconData _getIcon(String nombre) {
    switch (nombre) {
      case 'Blue':
        return Icons.attach_money;
      case 'Turista':
        return Icons.beach_access;
      case 'Bolsa':
        return Icons.business_center;
      case 'Contado con liquidación':
        return Icons.swap_horiz;
      case 'Solidario':
        return Icons.security;
      case 'Mayorista':
        return Icons.store;
      case 'Tarjeta':
        return Icons.credit_card;
      default:
        return Icons.monetization_on;
    }
  }

  // Función para mapear el nombre mostrado al nombre utilizado por la API
  String _getApiName(String nombre) {
    switch (nombre) {
      case 'Blue':
        return 'blue';
      case 'Turista':
        return 'turista';
      case 'Bolsa':
        return 'bolsa';
      case 'Contado con liquidación':
        return 'contadoliqui';
      case 'Solidario':
        return 'solidario';
      case 'Mayorista':
        return 'mayorista';
      case 'Tarjeta':
        return 'tarjeta';
      default:
        return 'oficial';
    }
  }
}
