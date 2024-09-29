import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dolarcito/bloc/events/dolar_event.dart';
import 'package:dolarcito/bloc/states/dolar_state.dart';
import 'package:dolarcito/data/services/api_service.dart';

class DolarBloc extends Bloc<DolarEvent, DolarState> {
  final ApiService apiService;
  Timer? _currentTimer;
  Timer? _historicalTimer;

  DolarBloc(this.apiService) : super(DolarInitial()) {
    on<FetchDolarEvent>(_onFetchDolarEvent);
    on<FetchHistoricalDolarEvent>(_onFetchHistoricalDolarEvent);
  }

  Future<void> _onFetchDolarEvent(
      FetchDolarEvent event, Emitter<DolarState> emit) async {
    await _fetchCurrentData(emit);

    // Inicia el temporizador que ejecuta la función cada 5 minutos
    _currentTimer?.cancel(); // Cancela cualquier timer existente
    _currentTimer = Timer.periodic(Duration(minutes: 5), (timer) async {
      if (!emit.isDone) {
        await _fetchCurrentData(emit);
      }
    });
  }

  Future<void> _fetchCurrentData(Emitter<DolarState> emit) async {
    emit(DolarLoading());
    try {
      final dolares = await apiService.fetchDolares();
      if (!emit.isDone) {
        emit(DolarLoaded(dolares));
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(DolarError('Error al cargar la cotización del dólar'));
      }
    }
  }

  Future<void> _onFetchHistoricalDolarEvent(
      FetchHistoricalDolarEvent event, Emitter<DolarState> emit) async {
    await _fetchHistoricalData(emit);

    // Inicia el temporizador que ejecuta la función cada 24 horas
    _historicalTimer?.cancel(); // Cancela cualquier timer existente
    _historicalTimer = Timer.periodic(Duration(hours: 24), (timer) async {
      if (!emit.isDone) {
        await _fetchHistoricalData(emit);
      }
    });
  }

  Future<void> _fetchHistoricalData(Emitter<DolarState> emit) async {
    emit(HistoricalDolarLoading());
    try {
      final historicalData = await apiService.fetchHistoricalDolares();
      if (!emit.isDone) {
        // Supongamos que historicalData es un Map con los tipos de dólar como clave
        emit(HistoricalDolarLoaded(historicalData));
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(HistoricalDolarError('Error al cargar los datos históricos'));
      }
    }
  }

  @override
  Future<void> close() {
    _currentTimer?.cancel();
    _historicalTimer?.cancel();
    return super.close();
  }
}
