import 'package:dolarcito/events/loginevent/loginevent.dart';
import 'package:dolarcito/repositories/auth_repositories.dart';
import 'package:dolarcito/states/loginstate/loginstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        await _authRepository.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(LoginSuccess());
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}