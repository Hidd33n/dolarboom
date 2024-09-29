import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DolarListWidget extends StatelessWidget {
  final List<dynamic> dolares;

  DolarListWidget({super.key, required this.dolares});

  final Color lightGreen = Colors.green[400]!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Oficial',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: lightGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Compra: ${dolares.firstWhere((d) => d["nombre"] == "Oficial")['compra']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Venta: ${dolares.firstWhere((d) => d["nombre"] == "Oficial")['venta']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Actualizado: ${DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(dolares.firstWhere((d) => d["nombre"] == "Oficial")['fechaActualizacion']))}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2.0,
              ),
              itemCount: dolares.length - 1,
              itemBuilder: (context, index) {
                final dolar = dolares.where((d) => d['nombre'] != 'Oficial').toList()[index];

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dolar['nombre'] == 'Contado con liquidación' ? 'CCL' : dolar['nombre'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: lightGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Compra: ${dolar['compra']}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Venta: ${dolar['venta']}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Actualizado: ${DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(dolar['fechaActualizacion']))}',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
