import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ComandaEvent extends Equatable {
  ComandaEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends ComandaEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { comanda: ${data.toString()}';
}

class DeleteButtonPressed extends ComandaEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { comanda: ${data.toString()}';
}

class ChangeFoodItemPressed extends ComandaEvent {
  final MapEntry comanda;

  ChangeFoodItemPressed({@required this.comanda}) : super([comanda]);

  @override
  String toString() =>
      'ChangeFoodItemPressed { buffet: ${comanda.toString()}';
}

class GetComanda extends ComandaEvent {

  GetComanda();

  @override
  String toString() =>
      'GetComanda';
}

class GetItensComanda extends ComandaEvent {
  final MapEntry comanda;
  GetItensComanda({@required this.comanda}) : super([comanda]);

  @override
  String toString() =>
      'GetItensComanda';
}

class GetComandaLogado extends ComandaEvent {

  GetComandaLogado();

  @override
  String toString() =>
      'GetComandaLogado';
}

class ComandaButtonPressed extends ComandaEvent {
  @override
  String toString() => 'ComandaButtonPressed';
}