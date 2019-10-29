import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritoEvent extends Equatable {
  FavoritoEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends FavoritoEvent {
  final Map data;

  SaveButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { favorito: ${data.toString()}';
}

class DeleteButtonPressed extends FavoritoEvent {
  final Map data;

  DeleteButtonPressed({@required this.data}) : super([data]);

  @override
  String toString() =>
      'SaveButtonPressed { favorito: ${data.toString()}';
}

class GetFavoritos extends FavoritoEvent {

  GetFavoritos();

  @override
  String toString() =>
      'GetFavorito';
}

class GetFavoritoLogado extends FavoritoEvent {

  GetFavoritoLogado();

  @override
  String toString() =>
      'GetFavoritoLogado';
}
