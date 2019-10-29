import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BuffetEvent extends Equatable {
  BuffetEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends BuffetEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { buffet: ${data.toString()}';
}



class DeleteButtonPressed extends BuffetEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { buffet: ${data.toString()}';
}

class GetBuffets extends BuffetEvent {

  GetBuffets();

  @override
  String toString() =>
      'GetBuffets';
}

class GetBuffet extends BuffetEvent {

  GetBuffet();

  @override
  String toString() =>
      'GetBuffet';
}
