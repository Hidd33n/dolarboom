import 'dart:async'; // Importar para usar Timer
import 'package:bloc/bloc.dart';
import 'package:dolarcito/bloc/events/dolar_event.dart';
import 'package:dolarcito/bloc/states/dolar_state.dart';
import 'package:dolarcito/data/services/api_service.dart';

class DolarBloc extends Bloc<DolarEvent, DolarState> {
  final ApiService apiService;
  Timer? _timer;

  DolarBloc(this.apiService) : super(DolarInitial()) {
    on<FetchDolarEvent>((event, emit) async {
      await _fetchData(emit);
      
      // Inicia el temporizador que ejecuta la función cada 5 minutos
      _timer?.cancel();  // Cancela cualquier timer existente
      _timer = Timer.periodic(Duration(minutes: 5), (timer) async {
        if (!emit.isDone) { // Verificamos que el emit aún esté disponible
          await _fetchData(emit);
        }
      });
    });
  }

  Future<void> _fetchData(Emitter<DolarState> emit) async {
    emit(DolarLoading());
    try {
      final dolares = await apiService.fetchDolares();
      if (!emit.isDone) { // Verificamos que el emit aún esté disponible
        emit(DolarLoaded(dolares));
      }
    } catch (e) {
      if (!emit.isDone) { // Verificamos que el emit aún esté disponible
        emit(DolarError('Error al cargar la cotización del dólar'));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
