import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ItensState extends Equatable {
  ItensState([List props = const []]) : super(props);
}

class ItensLoading extends ItensState {
  @override
  String toString() => 'ItensLoading';
}

class ItensInitial extends ItensState {
  final String mensagem;

  ItensInitial({@required this.mensagem});

  @override
  String toString() => 'ItensInitial';
}

class ItensFailure extends ItensState {
  final String error;

  ItensFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ItensFailure { error: $error }';
}

class ItensLoaded extends ItensState {
  final List<Map> itens;

  ItensLoaded({@required this.itens});

  @override
  String toString() => 'ItensLoaded';
}

class ItemLoaded extends ItensState {
  final Map item;

  ItemLoaded({@required this.item});

  @override
  String toString() => 'ItemLoaded';
}
