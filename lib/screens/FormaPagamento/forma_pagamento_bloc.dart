import 'dart:async';
import 'package:food_ordering_app/repository/forma_pagamento_repository.dart';
import 'package:food_ordering_app/screens/FormaPagamento/forma_pagamento_event.dart';
import 'package:food_ordering_app/screens/FormaPagamento/forma_pagamento_state.dart';
import 'package:bloc/bloc.dart';

class FormaPagamentoBloc extends Bloc<FormaPagamentoEvent, FormaPagamentoState> {
  final FormaPagamentoRepository formaPagamentoRepository;

  FormaPagamentoBloc(this.formaPagamentoRepository);

  @override
  FormaPagamentoState get initialState => FormaPagamentoInitial();

  @override
  Stream<FormaPagamentoState> mapEventToState(FormaPagamentoEvent event) async* {
    if (event is SaveButtonPressed) {
      yield FormaPagamentoLoading();

      try {

        String mensagem;
        if(event.data['id'] != null){
          print('id');
          mensagem = await formaPagamentoRepository.update(event.data['id'], event.data);
        } else {
          mensagem = await formaPagamentoRepository.create(event.data);
        }


        yield FormaPagamentoInitial(mensagem: mensagem);
      } catch (error) {
        yield FormaPagamentoFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield FormaPagamentoLoading();

      try {

        final mensagem = await formaPagamentoRepository.delete(event.data['id']);
        yield FormaPagamentoInitial(mensagem: mensagem);
      } catch (error) {
        yield FormaPagamentoFailure(error: error.toString());
      }
    }

    if(event is GetFormaPagamentoSelecionado){
      yield FormaPagamentoLoading();
      try{
        var data = await formaPagamentoRepository.get('h4IlI6brsTDZOpD3ORaY');
        yield FormaPagamentoLoaded(formaPagamento: data);

      } catch(error){
        yield FormaPagamentoFailure(error: error.toString());
      }
    }

    if(event is GetFormasPagamento){
      yield FormaPagamentoLoading();
      try{
        var data = await formaPagamentoRepository.getAll();
        yield FormasPagamentoLoaded(formasPagamento: data);

      } catch(error){
        yield FormaPagamentoFailure(error: error.toString());
      }
    }
  }
}
