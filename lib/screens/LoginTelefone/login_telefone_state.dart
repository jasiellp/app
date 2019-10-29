import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginTelefoneState extends Equatable {
  LoginTelefoneState([List props = const []]) : super(props);
}

class LoginTelefoneLoading extends LoginTelefoneState {
  @override
  String toString() => 'LoginTelefoneLoading';
}

class LoginTelefoneInitial extends LoginTelefoneState {
  final String mensagem;

  LoginTelefoneInitial({@required this.mensagem});

  @override
  String toString() => 'LoginTelefoneInitial';
}

class LoginTelefoneFailure extends LoginTelefoneState {
  final String error;

  LoginTelefoneFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginTelefoneFailure { error: $error }';
}

class LoginTelefonesLoaded extends LoginTelefoneState {
  final List<Map> usuarios;

  LoginTelefonesLoaded({@required this.usuarios});

  @override
  String toString() => 'LoginTelefonesLoaded';
}

class LoginTelefoneLoaded extends LoginTelefoneState {
  final Map usuario;

  LoginTelefoneLoaded({@required this.usuario});

  @override
  String toString() => 'LoginTelefoneLoaded';
}
