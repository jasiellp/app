import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/platform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/repository/usuario_repository.dart';

import 'login_telefone_bloc.dart';
import 'login_telefone_event.dart';
import 'login_telefone_state.dart';


class PhoneNumber extends StatefulWidget {
  PhoneNumber({Key key}) : super(key: key);

  @override
  _PhoneNumberState createState() => new _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _loginTelefoneBloc = LoginTelefoneBloc(UsuarioRepository());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  _PhoneNumberState();

  final TextEditingController _phone = TextEditingController();

  String verificationId;

  Future<void> _sendCodeToPhoneNumber() async {


    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        print('Received phone auth credential: $phoneAuthCredential');
      });
    };

    final PhoneVerificationFailed verificationFailed = (
        AuthException authException) {
      setState(() {
        print('Phone number verification failed. Code: ${authException
            .code}. Message: ${authException.message}');
      }
      );
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + _phone.text);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+55${_phone.text}",
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: new Text(
          "Login",
          style: new TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocListener(
        bloc: _loginTelefoneBloc,
        listener: (context, state) {
          if (state is LoginTelefoneInitial) {
            print('mensagem');
            //print(state.mensagem);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.mensagem),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is LoginTelefoneLoaded) {
          }
          if (state is LoginTelefoneFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<LoginTelefoneEvent, LoginTelefoneState>(
            bloc: _loginTelefoneBloc,
            builder: (
              BuildContext context,
              LoginTelefoneState state,
            ) {
              return new Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Informe seu número de telefone",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: const TextStyle(
                          color: const Color.fromRGBO(153, 153, 153, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                            border: new Border(
                          bottom: new BorderSide(
                            color: Colors.grey[400],
                          ),
                        )),
                        margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              alignment: Alignment.centerLeft,
                              width: 50.0,
                              child: new Text(
                                "+55-",
                                style: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                child: new TextField(
                                  controller: _phone,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new InkWell(
                          onTap: () async {

                            //await _sendCodeToPhoneNumber();

                            Map data = Map();
                            data['numero_telefone'] = _phone.text;

                            
                            _loginTelefoneBloc.dispatch(ProsseguirButtonPressed(data: data));
                          },
                          child: new Container(
                            child: new Text(
                              defaultTargetPlatform == TargetPlatform.iOS
                                  ? "Prosseguir"
                                  : "PROSSEGUIR",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            width: screenSize.width - 80,
                            height: 45.0,
//                margin: new EdgeInsets.only(
//                    top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                            alignment: FractionalOffset.center,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
