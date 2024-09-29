import 'package:dolarcito/bloc/main/historical_dolar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolarcito/bloc/events/historical_dolar_event.dart';
import 'package:dolarcito/bloc/states/historical_dolar_state.dart';
import 'package:dolarcito/data/services/api_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class DolarDetailScreen extends StatelessWidget {
  final String tipoDolar;
  final String displayName;

  DolarDetailScreen({required this.tipoDolar, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoricalDolarBloc(ApiService())
        ..add(FetchHistoricalDolarEvent(tipoDolar: tipoDolar)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$displayName - Histórico',
            style: GoogleFonts.bebasNeue(fontSize: 28, color: Colors.white),
          ),
          backgroundColor: Colors.blue[800],
        ),
        backgroundColor: Colors.grey[900], // Fondo gris oscuro para coherencia
        body: BlocBuilder<HistoricalDolarBloc, HistoricalDolarState>(
          builder: (context, state) {
            if (state is HistoricalDolarLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is HistoricalDolarLoaded) {
              final data = state.historicalData;

              if (data.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay datos disponibles.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              // Procesamos los datos para el gráfico
              List<FlSpot> spots = [];
              for (int i = 0; i < data.length; i++) {
                double y = double.parse(
                    data[i]['venta'].toString().replaceAll(',', '.'));
                spots.add(FlSpot(i.toDouble(), y));
              }

              // Obtener el precio actual
              final lastData = data.last;
              final currentPrice = lastData['venta'];
              final currentDate = lastData['fecha'];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Centramos el contenido
                    children: [
                      // Mostrar el precio actual
                      Text(
                        'Precio actual de $displayName',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$ $currentPrice',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(currentDate))}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Gráfico
                      Container(
                        height: 300, // Ajusta la altura según sea necesario
                        child: LineChart(
                          LineChartData(
                            backgroundColor: Colors.transparent,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: _calculateIntervalY(spots),
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toStringAsFixed(2),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: data.length / 5, // Mostrar 5 etiquetas
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= data.length || index < 0)
                                      return Container();
                                    String date = data[index]['fecha'];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        DateFormat('MM/yy').format(
                                            DateTime.parse(date)),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white70),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: _calculateIntervalY(spots),
                              getDrawingHorizontalLine: (value) {
                                return const FlLine(
                                  color: Colors.white10,
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: const Border(
                                left: BorderSide(color: Colors.white30),
                                bottom: BorderSide(color: Colors.white30),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                color: Colors.blue[300],
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue[300]!.withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                            // Añadir interactividad
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipColor: defaultLineTooltipColor,
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((spot) {
                                    final index = spot.x.toInt();
                                    if (index >= data.length || index < 0)
                                      return null;
                                    final date = DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(data[index]['fecha']));
                                    return LineTooltipItem(
                                      '${spot.y.toStringAsFixed(2)}\n$date',
                                      const TextStyle(color: Colors.white),
                                    );
                                  }).whereType<LineTooltipItem>().toList();
                                },
                              ),
                            ),
                          ),
   
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HistoricalDolarError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  double _calculateIntervalY(List<FlSpot> spots) {
    if (spots.isEmpty) return 1;
    double maxY =
        spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    double minY =
        spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return (maxY - minY) / 5;
  }
}
