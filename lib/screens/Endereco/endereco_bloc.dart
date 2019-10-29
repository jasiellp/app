import 'dart:async';
import 'package:food_ordering_app/repository/endereco_repository.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_state.dart';
import 'package:bloc/bloc.dart';

class EnderecoBloc extends Bloc<EnderecoEvent, EnderecoState> {
  final EnderecoRepository enderecoRepository;

  var _placeController = StreamController.broadcast();
  Stream get placeStream => _placeController.stream;

  EnderecoBloc(this.enderecoRepository);

  @override
  EnderecoState get initialState => EnderecoInitial();

  @override
  Stream<EnderecoState> mapEventToState(EnderecoEvent event) async* {
    if (event is SaveButtonPressed) {
      yield EnderecoLoading();

      try {

        final mensagem = await enderecoRepository.save(event.data);
        if(mensagem == 'fora do perimetro'){
          yield EnderecoFailure(error: "Endereço fora do perimetro permitido");
        } else {
          yield EnderecoInitial(mensagem: mensagem);
        }
      } catch (error) {
        yield EnderecoFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield EnderecoLoading();

      try {

        final mensagem = await enderecoRepository.delete(event.data['id']);
        yield EnderecoInitial(mensagem: mensagem);
      } catch (error) {
        yield EnderecoFailure(error: error.toString());
      }
    }

    if(event is GetEnderecos){
      yield EnderecoLoading();
      try{
        var data = await enderecoRepository.getAll();
        yield EnderecosLoaded(enderecos: data);

      } catch(error){
        print('error');
        print(error);
        yield EnderecoFailure(error: error.toString());
      }
    }

    if(event is GetEnderecoSelecionado){
      yield EnderecoLoading();
      try{
        var data = await enderecoRepository.get();
        //print(data);
        yield EnderecoLoaded(endereco: data);

      } catch(error){
        print('error');
        print(error);
        yield EnderecoFailure(error: error.toString());
      }
    }

    if(event is SearchEnderecos){
      _placeController.sink.add("start");
      try{

        if(event.keyword.length > 3){
          var data = await enderecoRepository.searchAddress(event.keyword);
          _placeController.sink.add(data);
        }

      } catch(error){
        print('error');
        print(error);
        yield EnderecoFailure(error: error.toString());
      }
    }
  }

  @override
  void dispose(){
    _placeController.close();
  }


}
