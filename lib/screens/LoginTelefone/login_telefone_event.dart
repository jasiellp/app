import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginTelefoneEvent extends Equatable {
  LoginTelefoneEvent([List props = const []]) : super(props);
}

class ProsseguirButtonPressed extends LoginTelefoneEvent {
  final Map data;

  ProsseguirButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { usuario: ${data.toString()}';
}

class DeleteButtonPressed extends LoginTelefoneEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { usuario: ${data.toString()}';
}

class GetLoginTelefones extends LoginTelefoneEvent {

  GetLoginTelefones();

  @override
  String toString() =>
      'GetLoginTelefones';
}

class GetLoginTelefoneLogado extends LoginTelefoneEvent {

  GetLoginTelefoneLogado();

  @override
  String toString() =>
      'GetLoginTelefoneLogado';
}
