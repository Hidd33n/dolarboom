abstract class DolarEvent {}

class FetchDolarEvent extends DolarEvent {}

class FetchHistoricalDolarEvent extends DolarEvent {
  final String tipoDolar;

  FetchHistoricalDolarEvent({required this.tipoDolar});
}