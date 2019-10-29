import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UsuarioEvent extends Equatable {
  UsuarioEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends UsuarioEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { usuario: ${data.toString()}';
}

class DeleteButtonPressed extends UsuarioEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { usuario: ${data.toString()}';
}

class GetUsuarios extends UsuarioEvent {

  GetUsuarios();

  @override
  String toString() =>
      'GetUsuarios';
}

class GetUsuarioLogado extends UsuarioEvent {

  GetUsuarioLogado();

  @override
  String toString() =>
      'GetUsuarioLogado';
}


class LogOffUsuario extends UsuarioEvent {
  LogOffUsuario();

  @override
  String toString() =>
      'LogOffUsuario';
}