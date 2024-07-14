import 'package:dolarcito/events/authevent/authevent.dart';
import 'package:dolarcito/repositories/auth_repositories.dart';
import 'package:dolarcito/states/authstate/authstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      final user = await _authRepository.user.first;
      if (user != null) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await _authRepository.signOut();
      emit(AuthenticationUnauthenticated());
    });
  }
}