import 'package:dolarcito/blocs/registerbloc/registerbloc.dart';
import 'package:dolarcito/events/registerevent/registerevent.dart';
import 'package:dolarcito/states/registerstate/registerstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
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
                    state is RegisterLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                RegisterButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            },
                            child: Text('Register'),
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