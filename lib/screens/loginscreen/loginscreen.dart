import 'package:dolarcito/blocs/loginbloc/loginbloc.dart';
import 'package:dolarcito/events/loginevent/loginevent.dart';
import 'package:dolarcito/states/loginstate/loginstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    state is LoginLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            },
                            child: Text('Login'),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}