import 'dart:async';
import 'package:food_ordering_app/repository/pedido_repository.dart';
import 'package:food_ordering_app/screens/Pedido/pedido_event.dart';
import 'package:food_ordering_app/screens/Pedido/pedido_state.dart';
import 'package:bloc/bloc.dart';

class PedidoBloc extends Bloc<PedidoEvent, PedidoState> {
  final PedidoRepository pedidoRepository;

  PedidoBloc(this.pedidoRepository);

  @override
  PedidoState get initialState => PedidoInitial();

  @override
  Stream<PedidoState> mapEventToState(PedidoEvent event) async* {
    if (event is SaveButtonPressed) {
      yield PedidoLoading();

      try {

        final mensagem = await pedidoRepository.create(event.data);
        yield PedidoInitial(mensagem: mensagem);
      } catch (error) {
        yield PedidoFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield PedidoLoading();

      try {

        final mensagem = await pedidoRepository.delete(event.data['id']);
        yield PedidoInitial(mensagem: mensagem);
      } catch (error) {
        yield PedidoFailure(error: error.toString());
      }
    }

    if(event is GetPedidoLogado){
      yield PedidoLoading();
      try{
        var data = await pedidoRepository.get('h4IlI6brsTDZOpD3ORaY');
        yield PedidoLoaded(pedido: data);

      } catch(error){
        yield PedidoFailure(error: error.toString());
      }
    }

    if(event is GetPedidos){
      yield PedidoLoading();
      try{
        var data = await pedidoRepository.getAll();
        yield PedidosLoaded(pedidos: data);

      } catch(error){
        yield PedidoFailure(error: error.toString());
      }
    }
  }
}
