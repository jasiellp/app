import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/repository/usuario_repository.dart';
import 'package:food_ordering_app/screens/AcompanhamentoPedido/acompanhamento_pedido_bloc.dart';
import 'package:food_ordering_app/screens/Conta/usuario_event.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:unique_identifier/unique_identifier.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final UsuarioRepository usuarioRepository;
  final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();


  UsuarioBloc(this.usuarioRepository);

  @override
  UsuarioState get initialState => UsuarioInitial();

  @override
  Stream<UsuarioState> mapEventToState(UsuarioEvent event) async* {
    if (event is SaveButtonPressed) {
      yield UsuarioLoading();

      try {
        String mensagem;
        if (event.data['id'] != null) {
          mensagem =
          await usuarioRepository.update(event.data['id'], event.data);
        } else {
          mensagem = await usuarioRepository.create(event.data);
        }


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

    if (event is GetUsuarioLogado) {
      yield UsuarioLoading();
      try {
        var data = await usuarioRepository.get('h4IlI6brsTDZOpD3ORaY');
        yield UsuarioLoaded(usuario: data);
      } catch (error) {
        yield UsuarioFailure(error: error.toString());
      }
    }

    if (event is GetUsuarios) {
      yield UsuarioLoading();
      try {
        var data = await usuarioRepository.getAll();
        yield UsuariosLoaded(usuarios: data);
      } catch (error) {
        yield UsuarioFailure(error: error.toString());
      }
    }

    if (event is LogOffUsuario) {
      yield UsuarioLoading();
      try {
        String identifier = await UniqueIdentifier.serial;
        Firestore.instance.collection('comanda').where(
            'fechado', isEqualTo: false)
            .where('device_id',isEqualTo: identifier)
            .getDocuments()
            .then((documento) =>
            documento.documents.forEach((del) => del.reference.delete()));
            FirebaseAuth.instance.signOut();
        _loginBloc.firebaseUser = null;
        yield UsuarioDeslogado();
      } catch (error) {
        yield UsuarioFailure(error: error.toString());
      }
    }
  }
}
