import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StreamingPricesScreen extends StatefulWidget {
  @override
  _StreamingPricesScreenState createState() => _StreamingPricesScreenState();
}

class _StreamingPricesScreenState extends State<StreamingPricesScreen> {
  bool _includeTaxes = false;

  // Datos simulados de precios de streaming
  final List<Map<String, dynamic>> _streamingServices = [
    {'name': 'Netflix', 'priceWithoutTax': 9.99, 'tax': 2.00},
    {'name': 'Disney+', 'priceWithoutTax': 7.99, 'tax': 1.50},
    {'name': 'Amazon Prime', 'priceWithoutTax': 12.99, 'tax': 2.50},
    {'name': 'Hulu', 'priceWithoutTax': 5.99, 'tax': 1.00},
  ];

  double _calculateTotal(double price, double tax) {
    return _includeTaxes ? price + tax : price;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Precios de Streaming',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SwitchListTile(
              title: Text(
                _includeTaxes ? 'Incluyendo Impuestos' : 'Sin Impuestos',
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
              value: _includeTaxes,
              activeColor: Colors.blueAccent,
              onChanged: (bool value) {
                setState(() {
                  _includeTaxes = value;
                });
              },
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _streamingServices.length,
              itemBuilder: (context, index) {
                final service = _streamingServices[index];
                return Card(
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.tv, color: Colors.white),
                    title: Text(
                      service['name'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '\$${_calculateTotal(service['priceWithoutTax'], service['tax']).toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
