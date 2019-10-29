import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:food_ordering_app/screens/LoginEmail/widgets/input_field.dart';
import 'package:food_ordering_app/screens/Registro/registro_bloc.dart';
import 'package:food_ordering_app/screens/Registro/registro_module.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _registroBloc = RegistroModule.to.getBloc<RegistroBloc>();

  @override
  void initState() {
    super.initState();

    //para exibir um dialogo na tela
    _registroBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.pop(context,  _registroBloc.firebaseUser);
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Falha ao criar conta"),
                    content: Text("Email existente!"),
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
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red),
            ),
          );
          break;
        case LoginState.IDLE:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.0,
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Criar Conta",
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
          stream: _registroBloc.outState,
          initialData: LoginState.IDLE,
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
                          InputField(
                            icon: Icons.perm_identity,
                            hint: "Nome",
                            obscure: false,
                            stream: _registroBloc.outNome,
                            onChanged: _registroBloc.changeNome,
                            typeKeyboard: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            icon: Icons.person_pin,
                            hint: "CPF/CNPJ",
                            obscure: false,
                            stream: _registroBloc.outCpfCnpj,
                            onChanged: _registroBloc.changeCpfCnpj,
                            typeKeyboard: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            icon: Icons.email,
                            hint: "Email",
                            obscure: false,
                            stream: _registroBloc.outEmail,
                            onChanged: _registroBloc.changeEmail,
                            typeKeyboard: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            icon: Icons.lock_outline,
                            hint: "Senha",
                            obscure: true,
                            stream: _registroBloc.outPassword,
                            onChanged: _registroBloc.changePassword,
                            typeKeyboard: TextInputType.text,
                          ),
                          SizedBox(height: 40.0,),
                          StreamBuilder<bool>(
                              stream: _registroBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 55,
                                  child: RaisedButton(
                                    color: Colors.red,
                                    disabledColor: Colors.grey,
                                    onPressed: snapshot.hasData
                                        ? _registroBloc.SignIn
                                        : null,
                                    child: Container(
                                      child: Text(
                                        defaultTargetPlatform ==
                                                TargetPlatform.android
                                            ? 'CADASTRAR'
                                            : 'Cadastrar',
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
