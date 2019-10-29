import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PedidoEvent extends Equatable {
  PedidoEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends PedidoEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { pedido: ${data.toString()}';
}

class DeleteButtonPressed extends PedidoEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { pedido: ${data.toString()}';
}

class GetPedidos extends PedidoEvent {

  GetPedidos();

  @override
  String toString() =>
      'GetPedidos';
}

class GetPedidoLogado extends PedidoEvent {

  GetPedidoLogado();

  @override
  String toString() =>
      'GetPedidoLogado';
}
