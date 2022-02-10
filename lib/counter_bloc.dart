import 'dart:async';

import 'package:bloc_example/counter_events.dart';

// Bloc is a Box where Event comes in and State comes out.
// Hence, we will need 2 stream, one for managing the event, one for managing the state ( here is the counter value)
class CounterBloc {
  // This is value stored, you will want to update this after an event is emitted
  int _counter = 0;

  // This is the stream controller for managing the value (state) of the bloc
  final _counterStateController = StreamController<int>();

  // This is the sink counter, where we start adding a new value to a stream
  StreamSink<int> get _inCounter => _counterStateController.sink;

  // This is a stream, where we listen to the change of the counter variable
  Stream<int> get counter => _counterStateController.stream;

  // This is the stream controller for managing the event of the bloc
  final _counterEventController = StreamController<CounterEvent>();

  // Because there is no event is out we will only need the Sink (where event comes in)
  StreamSink<CounterEvent> get counterEvent => _counterEventController;

  /// The thing we need to do now is handling the event. Which mean whenever the counter event controller receive an Event
  /// We will have to map it with an appropriate state
  /// Finally the UI will listen to the state of counter stream
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  // This is the mapper function. It will map event comes from counter event and emit the appropriate state

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementCounterEvent) {
      _counter++;
    } else {
      _counter--;
    }

    // Emit the counter state
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
