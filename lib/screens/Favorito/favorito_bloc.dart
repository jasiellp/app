import 'dart:async';
import 'package:food_ordering_app/repository/favorito_repository.dart';
import 'package:food_ordering_app/screens/Favorito/favorito_event.dart';
import 'package:food_ordering_app/screens/Favorito/favorito_state.dart';
import 'package:bloc/bloc.dart';

class FavoritoBloc extends Bloc<FavoritoEvent, FavoritoState> {
  final FavoritoRepository favoritoRepository;

  FavoritoBloc(this.favoritoRepository);

  @override
  FavoritoState get initialState => FavoritoInitial();

  @override
  Stream<FavoritoState> mapEventToState(FavoritoEvent event) async* {
    if (event is SaveButtonPressed) {
      yield FavoritoLoading();

      try {

        final mensagem = await favoritoRepository.create(event.data);
        yield FavoritoInitial(mensagem: mensagem);
      } catch (error) {
        yield FavoritoFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield FavoritoLoading();

      try {

        final mensagem = await favoritoRepository.delete(event.data['id']);
        yield FavoritoInitial(mensagem: mensagem);
      } catch (error) {
        yield FavoritoFailure(error: error.toString());
      }
    }

    if(event is GetFavoritoLogado){
      yield FavoritoLoading();
      try{
        var data = await favoritoRepository.get('h4IlI6brsTDZOpD3ORaY');
        yield FavoritoLoaded(favorito: data);

      } catch(error){
        yield FavoritoFailure(error: error.toString());
      }
    }

    if(event is GetFavoritos){
      yield FavoritoLoading();
      try{
        var data = await favoritoRepository.getAll();
        yield FavoritosLoaded(favoritos: data);

      } catch(error){
        yield FavoritoFailure(error: error.toString());
      }
    }
  }
}
