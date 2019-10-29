import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritoState extends Equatable {
  FavoritoState([List props = const []]) : super(props);
}

class FavoritoLoading extends FavoritoState {
  @override
  String toString() => 'FavoritoLoading';
}

class FavoritoInitial extends FavoritoState {
  final String mensagem;

  FavoritoInitial({@required this.mensagem});

  @override
  String toString() => 'FavoritoInitial';
}

class FavoritoFailure extends FavoritoState {
  final String error;

  FavoritoFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'FavoritoFailure { error: $error }';
}

class FavoritosLoaded extends FavoritoState {
  final List<Map> favoritos;

  FavoritosLoaded({@required this.favoritos});

  @override
  String toString() => 'FavoritosLoaded';
}

class FavoritoLoaded extends FavoritoState {
  final Map favorito;

  FavoritoLoaded({@required this.favorito});

  @override
  String toString() => 'FavoritoLoaded';
}
