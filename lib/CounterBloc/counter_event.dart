abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {
  IncrementCounter({required this.value});

  int value;
}

class DecrementCounter extends CounterEvent {
  DecrementCounter({required this.count});

  int count;
}
