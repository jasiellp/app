import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FormaPagamentoState extends Equatable {
  FormaPagamentoState([List props = const []]) : super(props);
}

class FormaPagamentoLoading extends FormaPagamentoState {
  @override
  String toString() => 'FormaPagamentoLoading';
}

class FormaPagamentoInitial extends FormaPagamentoState {
  final String mensagem;

  FormaPagamentoInitial({@required this.mensagem});

  @override
  String toString() => 'FormaPagamentoInitial';
}

class FormaPagamentoFailure extends FormaPagamentoState {
  final String error;

  FormaPagamentoFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'FormaPagamentoFailure { error: $error }';
}

class FormasPagamentoLoaded extends FormaPagamentoState {
  final List<Map> formasPagamento;

  FormasPagamentoLoaded({@required this.formasPagamento});

  @override
  String toString() => 'FormaPagamentosLoaded';
}

class FormaPagamentoLoaded extends FormaPagamentoState {
  final Map formaPagamento;

  FormaPagamentoLoaded({@required this.formaPagamento});

  @override
  String toString() => 'FormaPagamentoLoaded';
}
