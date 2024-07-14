import 'package:dolarcito/blocs/authbloc/authbloc.dart';
import 'package:dolarcito/blocs/loginbloc/loginbloc.dart';
import 'package:dolarcito/blocs/registerbloc/registerbloc.dart';
import 'package:dolarcito/events/authevent/authevent.dart';
import 'package:dolarcito/repositories/auth_repositories.dart';
import 'package:dolarcito/screens/homescreen/homescreen.dart';
import 'package:dolarcito/screens/loginscreen/loginscreen.dart';
import 'package:dolarcito/states/authstate/authstates.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final AuthRepository authRepository = AuthRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(authRepository: authRepository)
            ..add(AppStarted()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: authRepository),
        ),
      ],
      child: MyApp(authRepository: authRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Firebase Auth',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomeScreen();
          } else if (state is AuthenticationUnauthenticated) {
            return LoginScreen();
          } else if (state is AuthenticationLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return const Scaffold(body: Center(child: Text('Unknown state')));
          }
        },
      ),
    );
  }
}