// This is the base class of Counter events
// All  counter events will extends this class
// So before you implementing a feature, you first need to define all the event it might happened with the application
abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}
