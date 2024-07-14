// lib/screens/home_screen.dart
import 'package:dolarcito/blocs/authbloc/authbloc.dart';
import 'package:dolarcito/events/authevent/authevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
