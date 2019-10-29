import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PedidoState extends Equatable {
  PedidoState([List props = const []]) : super(props);
}

class PedidoLoading extends PedidoState {
  @override
  String toString() => 'PedidoLoading';
}

class PedidoInitial extends PedidoState {
  final String mensagem;

  PedidoInitial({@required this.mensagem});

  @override
  String toString() => 'PedidoInitial';
}

class PedidoFailure extends PedidoState {
  final String error;

  PedidoFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'PedidoFailure { error: $error }';
}

class PedidosLoaded extends PedidoState {
  final List<Map> pedidos;

  PedidosLoaded({@required this.pedidos});

  @override
  String toString() => 'PedidosLoaded';
}

class PedidoLoaded extends PedidoState {
  final Map pedido;

  PedidoLoaded({@required this.pedido});

  @override
  String toString() => 'PedidoLoaded';
}
