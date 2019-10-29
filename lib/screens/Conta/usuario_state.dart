import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UsuarioState extends Equatable {
  UsuarioState([List props = const []]) : super(props);
}

class UsuarioLoading extends UsuarioState {
  @override
  String toString() => 'UsuarioLoading';
}

class UsuarioInitial extends UsuarioState {
  final String mensagem;

  UsuarioInitial({@required this.mensagem});

  @override
  String toString() => 'UsuarioInitial';
}

class UsuarioFailure extends UsuarioState {
  final String error;

  UsuarioFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'UsuarioFailure { error: $error }';
}

class UsuariosLoaded extends UsuarioState {
  final List<Map> usuarios;

  UsuariosLoaded({@required this.usuarios});

  @override
  String toString() => 'UsuariosLoaded';
}

class UsuarioLoaded extends UsuarioState {
  final Map usuario;

  UsuarioLoaded({@required this.usuario});

  @override
  String toString() => 'UsuarioLoaded';
}


class UsuarioDeslogado extends UsuarioState {

  UsuarioDeslogado();

  @override
  String toString() => 'UsuarioDeslogado';
}