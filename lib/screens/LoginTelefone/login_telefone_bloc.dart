import 'dart:async';
import '../../repository/usuario_repository.dart';
import 'login_telefone_event.dart';
import 'login_telefone_state.dart';
import 'package:bloc/bloc.dart';

class LoginTelefoneBloc extends Bloc<LoginTelefoneEvent, LoginTelefoneState> {
  final UsuarioRepository usuarioRepository;

  LoginTelefoneBloc(this.usuarioRepository);

  @override
  LoginTelefoneState get initialState => LoginTelefoneInitial();

  @override
  Stream<LoginTelefoneState> mapEventToState(LoginTelefoneEvent event) async* {
    if (event is ProsseguirButtonPressed) {
      yield LoginTelefoneLoading();

      try {

        //final mensagem = await usuarioRepository.sendCodeToPhoneNumber(event.data);
        //yield LoginTelefoneInitial(mensagem: mensagem);
      } catch (error) {
        yield LoginTelefoneFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield LoginTelefoneLoading();

      try {

        final mensagem = await usuarioRepository.delete(event.data['id']);
        yield LoginTelefoneInitial(mensagem: mensagem);
      } catch (error) {
        yield LoginTelefoneFailure(error: error.toString());
      }
    }

    if(event is GetLoginTelefoneLogado){
      yield LoginTelefoneLoading();
      try{
        var data = await usuarioRepository.get('h4IlI6brsTDZOpD3ORaY');
        yield LoginTelefoneLoaded(usuario: data);

      } catch(error){
        yield LoginTelefoneFailure(error: error.toString());
      }
    }

    if(event is GetLoginTelefones){
      yield LoginTelefoneLoading();
      try{
        var data = await usuarioRepository.getAll();
        yield LoginTelefonesLoaded(usuarios: data);

      } catch(error){
        yield LoginTelefoneFailure(error: error.toString());
      }
    }
  }
}
