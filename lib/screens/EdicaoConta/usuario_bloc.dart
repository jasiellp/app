import 'dart:async';
import 'package:food_ordering_app/repository/usuario_repository.dart';
import 'package:food_ordering_app/screens/Conta/usuario_event.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';
import 'package:bloc/bloc.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final UsuarioRepository usuarioRepository;

  UsuarioBloc(this.usuarioRepository);

  @override
  UsuarioState get initialState => UsuarioInitial();

  @override
  Stream<UsuarioState> mapEventToState(UsuarioEvent event) async* {
    if (event is SaveButtonPressed) {
      yield UsuarioLoading();

      try {

        final mensagem = await usuarioRepository.create(event.data);
        yield UsuarioInitial(mensagem: mensagem);
      } catch (error) {
        yield UsuarioFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield UsuarioLoading();

      try {

        final mensagem = await usuarioRepository.delete(event.data['id']);
        yield UsuarioInitial(mensagem: mensagem);
      } catch (error) {
        yield UsuarioFailure(error: error.toString());
      }
    }

    if(event is GetUsuarioLogado){
      yield UsuarioLoading();
      try{
        var data = await usuarioRepository.get('h4IlI6brsTDZOpD3ORaY');
        print('retornou');
        //print(data);
        yield UsuarioLoaded(usuario: data);

      } catch(error){
        print('error');
        print(error);
        yield UsuarioFailure(error: error.toString());
      }
    }

    if(event is GetUsuarios){
      yield UsuarioLoading();
      try{
        var data = await usuarioRepository.getAll();
        //print('retornou');
        //print(data);
        yield UsuariosLoaded(usuarios: data);

      } catch(error){
        print('error');
        print(error);
        yield UsuarioFailure(error: error.toString());
      }
    }
  }
}
