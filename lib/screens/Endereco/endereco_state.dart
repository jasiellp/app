import 'package:food_ordering_app/model/place_item.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EnderecoState extends Equatable {
  EnderecoState([List props = const []]) : super(props);
}

class EnderecoLoading extends EnderecoState {
  @override
  String toString() => 'EnderecoLoading';
}

class EnderecoInitial extends EnderecoState {
  final String mensagem;

  EnderecoInitial({@required this.mensagem});

  @override
  String toString() => 'EnderecoInitial';
}

class EnderecoFailure extends EnderecoState {
  final String error;

  EnderecoFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'EnderecoFailure { error: $error }';
}

class EnderecosLoaded extends EnderecoState {
  final List<MapEntry> enderecos;

  EnderecosLoaded({@required this.enderecos});

  @override
  String toString() => 'EnderecosLoaded';
}

class EnderecoLoaded extends EnderecoState {
  final MapEntry endereco;

  EnderecoLoaded({@required this.endereco});

  @override
  String toString() => 'EnderecoLoaded';
}
