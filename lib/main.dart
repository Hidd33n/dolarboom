import 'package:dolarcito/bloc/main/dolar_bloc.dart';
import 'package:dolarcito/data/services/api_service.dart';
import 'package:dolarcito/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cotización del Dólar',
      home: BlocProvider(
        create: (context) => DolarBloc(ApiService()),
        child: HomeScreen(),
      ),
    );
  }
}
