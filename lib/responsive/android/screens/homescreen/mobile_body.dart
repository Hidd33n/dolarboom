
import 'package:dolarboom/bloc/main/currency_bloc.dart';
import 'package:dolarboom/bloc/states/currency_states.dart';
import 'package:dolarboom/data/models/streamingplans.dart';
import 'package:dolarboom/data/theme/themenotification.dart';
import 'package:dolarboom/globalwidgets/supportbutton.dart';
import 'package:dolarboom/responsive/android/widgets/m_currencyconverter.dart';
import 'package:dolarboom/responsive/android/widgets/m_dolar_list.dart';
import 'package:dolarboom/globalwidgets/streamingservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyMobileBody extends StatefulWidget {
  const MyMobileBody({super.key});

  @override
  State<MyMobileBody> createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {

  void _toggleTheme(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context, listen: false);
    themeNotifier.setThemeMode(
      Theme.of(context).brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth * 1; // Ocupa el 80% del ancho
          if (maxWidth > 800) {
            maxWidth = 800; // Ancho máximo de 500
          }
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    _buildHeader(context),
                    const SizedBox(height: 5),
                    _buildBetaBanner(context),
                    const SizedBox(height: 5),
                    _buildCurrencyConverter(context),
                    const SizedBox(height: 5),
                    SupportButton(),
                    _buildDollarList(context),
                    const SizedBox(height: 5),
                    _buildStreamingServices(context)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'D O L A R B O O M',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.nights_stay
                : Icons.wb_sunny,
          ),
          tooltip: 'Cambiar tema',
          onPressed: () => _toggleTheme(context),
        ),
      ],
    );
  }

  Widget _buildBetaBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Text(
        'BETA: Seguimos trabajando en nuevas funciones',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDollarList(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrencyLoaded) {
          return MobileDollarList(
            dollarRates: state.dollarRates,
            dollarIcons: dollarIcons, // Asegúrate de pasar el mapa de iconos
          );
        } else if (state is CurrencyError) {
          return const Center(child: Text('Error al cargar los datos'));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCurrencyConverter(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoaded) {
          return MobileCurrencyWidget(dollarRates: state.dollarRates);
        } else if (state is CurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrencyError) {
          return const Center(child: Text('Error al cargar los datos'));
        } else {
          return Container();
        }
      },
    );
  }
}

  // Nuevo método para mostrar las plataformas de streaming
  Widget _buildStreamingServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Plataformas de Streaming',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        StreamingServicesList(
          services: streamingServices,
        ),
      ],
    );
  }
