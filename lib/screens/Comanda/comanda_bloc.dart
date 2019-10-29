import 'dart:async';
import 'package:food_ordering_app/repository/comanda_repository.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_event.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_state.dart';
import 'package:bloc/bloc.dart';

class ComandaBloc extends Bloc<ComandaEvent, ComandaState> {
  final ComandaRepository comandaRepository;

  ComandaBloc(this.comandaRepository);

  MapEntry comanda = MapEntry(null, Map());
  Map<String,dynamic> endereco;

  final _pesoTotal = StreamController<String>();
  Stream<String> get outPesoTotal => _pesoTotal.stream;
  Sink<String> get inPesoTotal => _pesoTotal.sink;

  @override
  ComandaState get initialState => ComandaInitial();

  @override
  Stream<ComandaState> mapEventToState(ComandaEvent event) async* {
    if (event is ChangeFoodItemPressed) {
      try {
        final data = await comandaRepository.update(event.comanda);
        yield ComandaLoaded(comanda: data);
      } catch (error) {
        yield ComandaFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield ComandaLoading();

      try {

        final mensagem = await comandaRepository.delete(event.data['id']);
        yield ComandaInitial(mensagem: mensagem);
      } catch (error) {
        yield ComandaFailure(error: error.toString());
      }
    }

    if(event is GetComanda){
      yield ComandaLoading();
      try{
        var data = await comandaRepository.get();
        comanda = data;
        yield ComandaLoaded(comanda: data);

      } catch(error){
        yield ComandaFailure(error: error.toString());
      }
    }

    if(event is GetItensComanda){
      yield ComandaLoading();
      try{
        final data = await comandaRepository.getById(event.comanda.value['id']);
        yield ComandaLoaded(comanda: data);
      } catch(error){
        yield ComandaFailure(error: error.toString());
      }
    }

    if (event is ComandaButtonPressed) {
      yield ComandaLoaded();
    }
  }

}
