import 'package:flutter/material.dart';

class DollarList extends StatelessWidget {
  final List<dynamic> dollarRates;
  final Map<String, IconData> dollarIcons;

  const DollarList({
    Key? key,
    required this.dollarRates,
    required this.dollarIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Crear una copia de la lista para no modificar la original
    List<dynamic> sortedDollarRates = List.from(dollarRates);

    // Reemplazar 'Contado con liquidación' por 'CCL'
    sortedDollarRates = sortedDollarRates.map((rate) {
      if (rate['nombre'] == 'Contado con liquidación') {
        return {
          ...rate,
          'nombre': 'CCL',
        };
      }
      return rate;
    }).toList();

    // Mover el Dólar Oficial al inicio de la lista
    sortedDollarRates.sort((a, b) {
      if (a['nombre'] == 'Oficial') return -1;
      if (b['nombre'] == 'Oficial') return 1;
      return 0;
    });

    // Limitar el ancho máximo y centrar el contenido
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            // Mostrar el Dólar Oficial en una tarjeta destacada que ocupa todo el ancho
            _buildOfficialDollarCard(context, sortedDollarRates.first),
            const SizedBox(height: 16),
            // Mostrar el resto de las tarjetas en una cuadrícula
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedDollarRates.length - 1,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final rate = sortedDollarRates[index + 1]; // +1 para saltar el Dólar Oficial
                final String nombre = rate['nombre'];
                final IconData iconData = dollarIcons[nombre] ?? Icons.attach_money;

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(iconData, color: Theme.of(context).iconTheme.color, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Compra: ${rate['compra']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Venta: ${rate['venta']}',
                          style: const TextStyle(fontSize: 14),
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

  Widget _buildOfficialDollarCard(BuildContext context, dynamic rate) {
    final String nombre = rate['nombre'];
    final IconData iconData = dollarIcons[nombre] ?? Icons.attach_money;

    return Card(
      
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // Asegurar que la tarjeta ocupa todo el ancho disponible
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(iconData, color: Theme.of(context).iconTheme.color, size: 50),
            const SizedBox(height: 8),
            Text(
              nombre,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Compra: ${rate['compra']}',
              style: const TextStyle(fontSize: 18, ),
            ),
            Text(
              'Venta: ${rate['venta']}',
              style: const TextStyle(fontSize: 18, ),
            ),
          ],
        ),
      ),
    );
  }
}


Map<String, IconData> dollarIcons = {
  'Oficial': Icons.account_balance,          // Dólar oficial
  'Blue': Icons.money_off,                   // Dólar blue
  'Bolsa': Icons.trending_up,                // Dólar bolsa
  'Contado con liquidación': Icons.swap_horiz, // Dólar contado con liquidación
  'Mayorista': Icons.store,                  // Dólar mayorista
  'Cripto': Icons.currency_bitcoin,          // Dólar cripto (requiere Flutter 2.5 o superior)
  'Tarjeta': Icons.credit_card,              // Dólar tarjeta
};