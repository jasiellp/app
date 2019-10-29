import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ItensEvent extends Equatable {
  ItensEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends ItensEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { item: ${data.toString()}';
}

class DeleteButtonPressed extends ItensEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { item: ${data.toString()}';
}

class GetItens extends ItensEvent {

  GetItens();

  @override
  String toString() =>
      'GetItens';
}

class GetItemSelecionado extends ItensEvent {
  final String id;

  GetItemSelecionado({@required this.id}) : super([id]);

  @override
  String toString() =>
      'GetItemSelecionado';
}
