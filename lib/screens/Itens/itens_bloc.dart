import 'dart:async';
import 'package:food_ordering_app/repository/itens_repository.dart';
import 'package:bloc/bloc.dart';

import 'itens_event.dart';
import 'itens_state.dart';

class ItensBloc extends Bloc<ItensEvent, ItensState> {
  final ItensRepository itensRepository;

  ItensBloc(this.itensRepository);

  @override
  ItensState get initialState => ItensInitial();

  @override
  Stream<ItensState> mapEventToState(ItensEvent event) async* {
    if (event is SaveButtonPressed) {
      yield ItensLoading();

      try {

        final mensagem = await itensRepository.create(event.data);
        yield ItensInitial(mensagem: mensagem);
      } catch (error) {
        yield ItensFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield ItensLoading();

      try {

        final mensagem = await itensRepository.delete(event.data['id']);
        yield ItensInitial(mensagem: mensagem);
      } catch (error) {
        yield ItensFailure(error: error.toString());
      }
    }

    if(event is GetItemSelecionado){
      yield ItensLoading();
      try{
        var data = await itensRepository.get(event.id);
        yield ItemLoaded(item: data);

      } catch(error){
        yield ItensFailure(error: error.toString());
      }
    }

    if(event is GetItens){
      yield ItensLoading();
      try{
        var data = await itensRepository.getAll();
        yield ItensLoaded(itens: data);

      } catch(error){
        yield ItensFailure(error: error.toString());
      }
    }
  }
}
