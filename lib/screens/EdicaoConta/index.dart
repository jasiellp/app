
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/platform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/repository/usuario_repository.dart';
import 'package:food_ordering_app/screens/Conta/usuario_bloc.dart';
import 'package:food_ordering_app/screens/Conta/usuario_event.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';
import 'package:food_ordering_app/theme/style.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/repository/usuario_repository.dart';
import 'package:food_ordering_app/screens/Conta/usuario_bloc.dart';
import 'package:food_ordering_app/screens/Conta/usuario_event.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';

class EdicaoConta extends StatefulWidget {
  final Map usuario;

  EdicaoConta({Key key, this.usuario}) : super(key: key);

  @override
  _EdicaoContaState createState() =>
      new _EdicaoContaState(usuario: this.usuario);
}

class _EdicaoContaState extends State<EdicaoConta> {
  Map usuario;
  final _usuarioBloc = UsuarioBloc(UsuarioRepository());
  final TextEditingController _id = new TextEditingController();
  final TextEditingController _nome = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _celular = new TextEditingController();
  final TextEditingController _cpf = new TextEditingController();

  _EdicaoContaState({this.usuario});

  @override
  void initState() {
    _id.text = usuario['id'];
    _nome.text = usuario['nome'];
    _email.text = usuario['email'];
    _celular.text = usuario['celular'];
    _cpf.text = usuario['cpf'];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(
                Icons.chevron_left,
                size: 40.0,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: new Text(
            "Editar Dados",
            style: new TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocListener(
          bloc: _usuarioBloc,
          listener: (context, state) {
            if (state is UsuarioInitial) {
//              print('mensagem');
//              print(state.mensagem);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.mensagem),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is UsuarioLoaded) {
              setState(() {
                usuario = state.usuario;
              });
            }
            if (state is UsuarioFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<UsuarioEvent, UsuarioState>(
              bloc: _usuarioBloc,
              builder: (BuildContext context,
                  UsuarioState state,) {
                return Container(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Column(
                      children: <Widget>[
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Nome completo',
                          textAlign: TextAlign.end,
                          customWidth: 2.0,
                          controller: _nome,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'CPF (opcional)',
                          textAlign: TextAlign.end,
                          customWidth: 2.0,
                          controller: _cpf,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          textAlign: TextAlign.end,
                          title: 'Celular',
                          customWidth: 2.0,
                          controller: _celular,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'E-Mail',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _email,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        InkWell(
                          onTap: () {
                            usuario['id'] = _id.text;
                            usuario['nome'] = _nome.text;
                            usuario['email'] = _email.text;
                            usuario['cpf'] = _cpf.text;
                            usuario['celular'] = _celular.text;

                            _usuarioBloc.dispatch(SaveButtonPressed(data: usuario));
                          },
                          child:
                          Container(
                            child: new Text('Confirmar',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            width: screenSize.width - 20,
                            height: 45.0,
                            alignment: FractionalOffset.center,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                              const BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    )

                );
              }),)


    );
  }
}
