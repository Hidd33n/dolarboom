abstract class DolarState {}

class DolarInitial extends DolarState {}

class DolarLoading extends DolarState {}

class DolarLoaded extends DolarState {
  final List<dynamic> dolares;
  DolarLoaded(this.dolares);
}



class HistoricalDolarLoading extends DolarState {}

class HistoricalDolarLoaded extends DolarState {
  final Map<String, List<dynamic>> historicalData;

  HistoricalDolarLoaded(this.historicalData);
}

class HistoricalDolarError extends DolarState {
  final String message;

  HistoricalDolarError(this.message);
}
class DolarError extends DolarState {
  final String message;
  DolarError(this.message);
}
