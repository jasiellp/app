import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc extends BlocBase with LoginValidators {
  FirebaseUser firebaseUser;
  final _nomeController = BehaviorSubject<String>();
  final _cpfCnpjController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  final _loginBloc = BlocProvider.getBloc<LoginBloc>();

  Stream<LoginState> get outState => _stateController.stream;

  Stream<String> get outNome => _nomeController.stream.transform(validateNome);

  Function(String) get changeNome => _nomeController.sink.add;

  Stream<String> get outCpfCnpj =>
      _cpfCnpjController.stream.transform(validateCpfCnpj);

  Function(String) get changeCpfCnpj => _cpfCnpjController.sink.add;

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Function(String) get changeEmail => _emailController.sink.add;

  Stream<String> get outPassword =>
      _senhaController.stream.transform(validateSenha);

  Function(String) get changePassword => _senhaController.sink.add;

  Stream<bool> get outSubmitValid => Observable.combineLatest4(
      outNome, outCpfCnpj, outEmail, outPassword, (a, b, c, d) => true);

  void SignIn() {
    final nome = _nomeController.value;
    final cpfCnpj = _cpfCnpjController.value;
    final email = _emailController.value;
    final password = _senhaController.value;
    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      _loginBloc.firebaseUser = user;
      firebaseUser = user;
      Firestore.instance.collection('usuarios').document(user.uid).setData({
        'data_acesso': DateTime.now(),
        'email': user.email,
        'nome': nome,
        'cpf_cnpj': cpfCnpj
      });
      _stateController.add(LoginState.SUCCESS);
    }).catchError((e) {
      print(e.toString());
      _stateController.add(LoginState.FAIL);
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    _nomeController.close();
    _cpfCnpjController.close();
    _emailController.close();
    _senhaController.close();
    super.dispose();
  }
}
