// bloc/currency_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:dolarboom/bloc/events/currency_event.dart';
import 'package:dolarboom/bloc/states/currency_states.dart';
import 'package:dolarboom/data/services/api_service.dart';


class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final ApiService apiService;

  CurrencyBloc({required this.apiService}) : super(CurrencyInitial()) {
    on<FetchCurrency>((event, emit) async {
      emit(CurrencyLoading());
      try {
        final rates = await apiService.fetchDolares();
        emit(CurrencyLoaded(dollarRates: rates));
      } catch (e) {
        emit(CurrencyError(message: e.toString()));
      }
    });
  }
}
