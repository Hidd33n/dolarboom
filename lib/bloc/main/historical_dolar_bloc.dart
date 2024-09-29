import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolarcito/bloc/events/historical_dolar_event.dart';
import 'package:dolarcito/bloc/states/historical_dolar_state.dart';
import 'package:dolarcito/data/services/api_service.dart';

class HistoricalDolarBloc extends Bloc<HistoricalDolarEvent, HistoricalDolarState> {
  final ApiService apiService;

  HistoricalDolarBloc(this.apiService) : super(HistoricalDolarInitial()) {
    on<FetchHistoricalDolarEvent>(_onFetchHistoricalDolarEvent);
  }

  Future<void> _onFetchHistoricalDolarEvent(
      FetchHistoricalDolarEvent event, Emitter<HistoricalDolarState> emit) async {
    emit(HistoricalDolarLoading());
    try {
      final data = await apiService.fetchHistoricalDolaresByType(event.tipoDolar.toLowerCase());
      emit(HistoricalDolarLoaded(historicalData: data));
    } catch (e) {
      emit(HistoricalDolarError(message: 'Error al cargar los datos históricos'));
    }
  }
}
