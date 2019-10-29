import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FormaPagamentoEvent extends Equatable {
  FormaPagamentoEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends FormaPagamentoEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { formaPagamento: ${data.toString()}';
}

class DeleteButtonPressed extends FormaPagamentoEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { formaPagamento: ${data.toString()}';
}

class GetFormasPagamento extends FormaPagamentoEvent {

  GetFormasPagamento();

  @override
  String toString() =>
      'GetFormasPagamento';
}

class GetFormaPagamentoSelecionado extends FormaPagamentoEvent {

  GetFormaPagamentoSelecionado();

  @override
  String toString() =>
      'GetFormaPagamentoSelecionado';
}
