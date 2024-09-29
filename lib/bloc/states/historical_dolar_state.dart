abstract class HistoricalDolarState {}

class HistoricalDolarInitial extends HistoricalDolarState {}

class HistoricalDolarLoading extends HistoricalDolarState {}

class HistoricalDolarLoaded extends HistoricalDolarState {
  final List<dynamic> historicalData;

  HistoricalDolarLoaded({required this.historicalData});
}

class HistoricalDolarError extends HistoricalDolarState {
  final String message;

  HistoricalDolarError({required this.message});
}
