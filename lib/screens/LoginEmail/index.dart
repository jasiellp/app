import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_app/screens/LoginEmail/widgets/input_field.dart';

import 'login_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    //para exibir um dialogo na tela
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.pop(context, _loginBloc.firebaseUser);
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Falha ao logar"),
                    content: Text("Usuário não encontrado!"
                        "\nVerifique seu email e senha!"),
                    actions: <Widget>[
                      new FlatButton(
                        child: Text(
                          'Fechar',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.0,
        title: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
          child: Text(
            "Login",
          ),
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Colors.red[700],
                    ),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
              default:
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SingleChildScrollView(
                        child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            icon: Icons.person_outline,
                            hint: "Email",
                            obscure: false,
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            icon: Icons.lock_outline,
                            hint: "Senha",
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    if (_loginBloc.retornaEmail() == null ||
                                        _loginBloc.retornaEmail().isEmpty) {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Informar Email"),
                                        backgroundColor: Colors.red[700],
                                      ));
                                    } else {
                                      _loginBloc.recoverPass(
                                          _loginBloc.retornaEmail());
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Verifique sua caixa de email"),
                                        backgroundColor: Colors.green[500],
                                      ));
                                    }
                                  },
                                  child: Text(
                                    "Esqueci minha senha",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
//                                if(!snapshot.hasData) return Container();
                                return SizedBox(
                                  height: 55,
                                  child: RaisedButton(
                                    color: Colors.red,
                                    disabledColor: Colors.grey,
                                    onPressed: snapshot.hasData
                                        ? _loginBloc.logar
                                        : null,
                                    child: Container(
                                      child: Text(
                                        defaultTargetPlatform ==
                                                TargetPlatform.android
                                            ? 'ENTRAR'
                                            : 'Entrar',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      height: 45.0,
                                      alignment: FractionalOffset.center,
                                      decoration: const BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(height: 15.0,),
                                Text("Não tem uma conta?"),
                                FlatButton(
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context, "/Registro");
                                  },
                                  child: Text(
                                    "Cadastre-se",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.red[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                );
            }
          }),
    );
  }
}
