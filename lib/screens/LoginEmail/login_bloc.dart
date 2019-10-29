import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'login_validator.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  FirebaseUser firebaseUser;

  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  String retornaEmail(){
    return _emailController.value;
  }

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Function(String) get changeEmail => _emailController.sink.add;

  Stream<String> get outPassword =>
      _senhaController.stream.transform(validateSenha);

  Function(String) get changePassword => _senhaController.sink.add;

  Stream<LoginState> get outState => _stateController.stream;

  //Valida se os dois campos estão preenchidos e validos para habilitar o botão de Entrar
  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  //usando para fechar o subscription quando ocorrer o dispose do bloc
  StreamSubscription _streamSubscription;

  LoginBloc() {
    //verifica se o usuário já estava logado ou não
    _streamSubscription =
        FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      if (user != null) {
        firebaseUser = user;
        _stateController.add(LoginState.SUCCESS);
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void logar() {
    final email = _emailController.value;
    final password = _senhaController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      Firestore.instance
          .collection('usuarios')
          .document(user.uid)
          .setData({'data_acesso': DateTime.now(), 'email': user.email},merge: true);
      firebaseUser = user;
    }).catchError((e) {
      _stateController.add(LoginState.FAIL);
      _emailController.value = "";
      _senhaController.value = "";
    });
  }

  void logoff() async {
    String identifier = await UniqueIdentifier.serial;
    Firestore.instance.collection('comanda').where(
        'fechado', isEqualTo: false)
        .where('device_id',isEqualTo: identifier)
        .getDocuments()
        .then((documento) =>
        documento.documents.forEach((del) => del.reference.delete()));
    FirebaseAuth.instance.signOut();
    firebaseUser = null;
  }

  void statusInicial() async{
      String identifier = await UniqueIdentifier.serial;
      Firestore.instance.collection('comanda').where(
          'fechado', isEqualTo: false)
          .where('device_id',isEqualTo: identifier)
          .getDocuments()
          .then((documento) =>
          documento.documents.forEach((del) => del.reference.delete()));
  }

  void recoverPass(String email) {
    //envia o email
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<String> usuarioAtual() async {
    if (firebaseUser == null)
      firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      return firebaseUser.email;
    }
    return "";
  }

  Future<bool> eAdmin(FirebaseUser user) async {
    return await Firestore.instance
        .collection("usuarios")
        .document(user.uid)
        .get()
        .then((doc) {
      if (doc.data != null) {
        if (doc.data["admin"]) {
          return true;
        }
        return false;
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
}
