import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BuffetState extends Equatable {
  BuffetState([List props = const []]) : super(props);
}

class BuffetLoading extends BuffetState {
  @override
  String toString() => 'BuffetLoading';
}

class BuffetInitial extends BuffetState {
  final String key;

  BuffetInitial({@required this.key});

  @override
  String toString() => 'BuffetInitial';
}

class BuffetFailure extends BuffetState {
  final String error;

  BuffetFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'BuffetFailure { error: $error }';
}

class BuffetsLoaded extends BuffetState {
  final List<Map> buffets;

  BuffetsLoaded({@required this.buffets});

  @override
  String toString() => 'BuffetsLoaded';
}

class BuffetLoaded extends BuffetState {
  final MapEntry buffet;

  BuffetLoaded({@required this.buffet});

  @override
  String toString() => 'BuffetLoaded';
}
