import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<IncrementCounter>((event, emit) {
      emit(CounterState(count: state.count + event.value));
    });

    on<DecrementCounter>((event, emit) {
      emit(CounterState(count: state.count - event.count));
    });
  }
}
