// lib/main.dart
import 'package:dolarboom/bloc/events/dolar_event.dart';
import 'package:dolarboom/bloc/main/currency_bloc.dart';
import 'package:dolarboom/bloc/events/currency_event.dart';
import 'package:dolarboom/data/theme/theme.dart';
import 'package:dolarboom/data/theme/themenotification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolarboom/bloc/main/dolar_bloc.dart';
import 'package:dolarboom/data/services/api_service.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:dolarboom/homescreen.dart';

void main() {
    if (kIsWeb) {
    MetaSEO().config();
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModeNotifier.instance,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DolarBloc(ApiService())..add(FetchDolarEvent()),
          ),
          BlocProvider(
            create: (context) => CurrencyBloc(apiService: ApiService())..add(FetchCurrency()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, themeModeNotifier, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeModeNotifier.themeMode,
          home: const Homescreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
