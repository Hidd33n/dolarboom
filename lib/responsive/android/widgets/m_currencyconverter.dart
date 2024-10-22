import 'package:dolarboom/globalwidgets/dollar_icons.dart';
import 'package:dolarboom/globalwidgets/gradianttextfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MobileCurrencyWidget extends StatefulWidget {
  final List<dynamic> dollarRates;

  const MobileCurrencyWidget({Key? key, required this.dollarRates}) : super(key: key);

  @override
  _MobileCurrencyWidgetState createState() => _MobileCurrencyWidgetState();
}

class _MobileCurrencyWidgetState extends State<MobileCurrencyWidget> {
 final _controller = TextEditingController();
  double? _inputAmount;
  Map<String, Map<String, double>> _convertedAmounts = {};

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onAmountChanged);
    _calculateConversions();
  }

  @override
  void dispose() {
    _controller.removeListener(_onAmountChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final input = double.tryParse(_controller.text.replaceAll(',', '.'));
    setState(() {
      _inputAmount = input;
      _calculateConversions();
    });
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un monto';
    }
    final number = double.tryParse(value.replaceAll(',', '.'));
    if (number == null) {
      return 'Ingrese un número válido';
    }
    return null;
  }

  void _calculateConversions() {
    final oficialRate = _getRateByName('Oficial');
    final blueRate = _getRateByName('Blue');
    final tarjetaRate = _getRateByName('Tarjeta');

    setState(() {
      _convertedAmounts = {
        'Oficial': _inputAmount != null && _inputAmount! > 0
            ? _calculateWithTaxes(_inputAmount!, oficialRate)
            : _emptyConversion(),
        'Blue': _inputAmount != null && _inputAmount! > 0
            ? _calculateWithTaxes(_inputAmount!, blueRate)
            : _emptyConversion(),
        'Tarjeta': _inputAmount != null && _inputAmount! > 0
            ? _calculateWithTaxes(_inputAmount!, tarjetaRate)
            : _emptyConversion(),
      };
    });
  }

  Map<String, double> _calculateWithTaxes(double amountUSD, double rateUSDToARS) {
    double ars = amountUSD * rateUSDToARS;
    double iva = ars * 0.21;
    double pais = ars * 0.08;
    double ganancias = ars * 0.30;
    double total = ars + iva + pais + ganancias;

    return {
      'ARS': ars,
      'IVA': iva,
      'PAIS': pais,
      'Ganancias': ganancias,
      'Total': total,
    };
  }

  Map<String, double> _emptyConversion() {
    return {
      'ARS': 0.0,
      'IVA': 0.0,
      'PAIS': 0.0,
      'Ganancias': 0.0,
      'Total': 0.0,
    };
  }

  double _getRateByName(String name) {
    final rate = widget.dollarRates.firstWhere(
      (rate) => rate['nombre'] == name,
      orElse: () => {'venta': 1.0},
    );
    return rate['venta'] != null ? rate['venta'].toDouble() : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo de Entrada con Gradiente
                GradientTextField(
                  controller: _controller,
                  onChanged: (value) => _onAmountChanged(),
                  validator: _validateAmount,
                ),
                const SizedBox(height: 20),

                // Sección de Impuestos (Siempre Visible)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Impuestos',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Fila de Impuestos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['Blue', 'Oficial', 'Tarjeta'].map((rateName) {
                        Map<String, double> amounts =
                            _convertedAmounts[rateName] ?? _emptyConversion();
                        double totalImpuestos =
                            amounts['IVA']! + amounts['PAIS']! + amounts['Ganancias']!;
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Imp. $rateName',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  'IVA (21%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  'PAIS (8%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  'GANANCIAS (30%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'ARS ${NumberFormat('#,##0.00', 'es_AR').format(totalImpuestos)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Tarjetas de Conversión
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['Blue', 'Oficial', 'Tarjeta'].map((rateName) {
                    Map<String, double> amounts =
                        _convertedAmounts[rateName] ?? _emptyConversion();
                    return _buildConversionCard(rateName, amounts);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConversionCard(String dollarType, Map<String, double> amounts) {
    final formatter = NumberFormat('#,##0.00', 'es_AR');
    final IconData iconData = dollarIcons[dollarType] ?? Icons.attach_money;

    return Expanded(
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.95),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Theme.of(context).iconTheme.color,
                size: 40,
                semanticLabel: '$dollarType Icon',
              ),
              const SizedBox(height: 8),
              Text(
                dollarType.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Divider(height: 20, thickness: 1),
              Text(
                'ARS: ${formatter.format(amounts['ARS'])}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
