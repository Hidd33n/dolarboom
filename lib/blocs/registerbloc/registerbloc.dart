import 'package:dolarcito/events/registerevent/registerevent.dart';
import 'package:dolarcito/repositories/auth_repositories.dart';
import 'package:dolarcito/states/registerstate/registerstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());

      try {
        await _authRepository.signUpWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(RegisterSuccess());
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
      }
    });
  }
}