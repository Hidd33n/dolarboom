import 'package:dolarcito/bloc/events/dolar_event.dart';
import 'package:dolarcito/bloc/main/dolar_bloc.dart';
import 'package:dolarcito/bloc/states/dolar_state.dart';
import 'package:dolarcito/widgets/dolarlist/dolar_list.dart';
import 'package:dolarcito/widgets/cambios/cambios.dart'; // Importamos el nuevo widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Importamos Google Fonts

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<DolarBloc>().add(FetchDolarEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dolarcito',
          style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: BlocBuilder<DolarBloc, DolarState>(
        builder: (context, state) {
          if (state is DolarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DolarLoaded) {
            return Column(
              children: [
                // Parte superior con color verde oscuro, bordes redondeados y sombra
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Calculadora de Cotización',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Incluir el CambiosWidget dentro del contenedor
                      CambiosWidget(dolares: {
                        'Blue': state.dolares.firstWhere((d) => d['nombre'] == 'Blue'),
                        'Oficial': state.dolares.firstWhere((d) => d['nombre'] == 'Oficial'),
                        'Tarjeta': state.dolares.firstWhere((d) => d['nombre'] == 'Tarjeta'),
                      }),
                    ],
                  ),
                ),
                // Parte blanca que muestra las cotizaciones
                Expanded(
                  child: DolarListWidget(dolares: state.dolares),
                ),
              ],
            );
          } else if (state is DolarError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
