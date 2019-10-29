import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ComandaState extends Equatable {
  ComandaState([List props = const []]) : super(props);
}

class ComandaLoading extends ComandaState {
  @override
  String toString() => 'ComandaLoading';
}

class ComandaInitial extends ComandaState {
  final String mensagem;

  ComandaInitial({@required this.mensagem});

  @override
  String toString() => 'ComandaInitial';
}

class ComandaFailure extends ComandaState {
  final String error;

  ComandaFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ComandaFailure { error: $error }';
}

class ComandasLoaded extends ComandaState {
  final List<Map> comandas;

  ComandasLoaded({@required this.comandas});

  @override
  String toString() => 'ComandasLoaded';
}

class ComandaLoaded extends ComandaState {
  final MapEntry comanda;

  ComandaLoaded({@required this.comanda});

  @override
  String toString() => 'ComandaLoaded';
}

bool get isComandaValid => false;