import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolarcito/bloc/main/dolar_bloc.dart';
import 'package:dolarcito/bloc/states/dolar_state.dart';
import 'package:dolarcito/widgets/dolarlist/dolar_oficial.dart';
import 'package:dolarcito/widgets/dolarlist/dolar_list.dart';
import 'package:dolarcito/widgets/cambios/cambios.dart';
import 'package:google_fonts/google_fonts.dart';

class DolarMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolarBloc, DolarState>(
      builder: (context, state) {
        if (state is DolarLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (state is DolarLoaded) {
          final dolarOficial =
              state.dolares.firstWhere((d) => d["nombre"] == "Oficial", orElse: () => null);

          if (dolarOficial == null) {
            return Center(
              child: Text(
                'No se encontró el dólar oficial.',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // Encabezado
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calculadora de Cotización',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CambiosWidget(dolares: {
                          'Blue': state.dolares
                              .firstWhere((d) => d['nombre'] == 'Blue', orElse: () => null),
                          'Oficial': dolarOficial,
                          'Tarjeta': state.dolares
                              .firstWhere((d) => d['nombre'] == 'Tarjeta', orElse: () => null),
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              // Espacio
              SliverToBoxAdapter(
                child: const SizedBox(height: 16),
              ),
              // Dólar Oficial
              DolarOficialWidget(dolarOficial: dolarOficial),
              // Espacio
              SliverToBoxAdapter(
                child: const SizedBox(height: 16),
              ),
              // Grid de otros tipos de dólar (nuevo widget)
              DolarListWidget(
                dolares: state.dolares
                    .where((d) => d['nombre'] != 'Oficial')
                    .toList(),
              ),
            ],
          );
        } else if (state is DolarError) {
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
    );
  }
}
