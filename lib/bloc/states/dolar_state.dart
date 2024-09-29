abstract class DolarState {}

class DolarInitial extends DolarState {}

class DolarLoading extends DolarState {}

class DolarLoaded extends DolarState {
  final List<dynamic> dolares;
  DolarLoaded(this.dolares);
}

class DolarError extends DolarState {
  final String message;
  DolarError(this.message);
}
