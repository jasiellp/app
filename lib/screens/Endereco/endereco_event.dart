import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EnderecoEvent extends Equatable {
  EnderecoEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends EnderecoEvent {
  final MapEntry data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { endereco: ${data.toString()}';
}

class DeleteButtonPressed extends EnderecoEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { endereco: ${data.toString()}';
}

class GetEnderecos extends EnderecoEvent {

  GetEnderecos();

  @override
  String toString() =>
      'GetEnderecos';
}

class SearchEnderecos extends EnderecoEvent {
  final String keyword;

  SearchEnderecos({@required this.keyword});

  @override
  String toString() =>
      'SearchEnderecos';
}

class GetEnderecoSelecionado extends EnderecoEvent {

  GetEnderecoSelecionado();

  @override
  String toString() =>
      'GetEnderecoSelecionado';
}
