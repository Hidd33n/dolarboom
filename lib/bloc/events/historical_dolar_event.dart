abstract class HistoricalDolarEvent {}

class FetchHistoricalDolarEvent extends HistoricalDolarEvent {
  final String tipoDolar;

  FetchHistoricalDolarEvent({required this.tipoDolar});
}
