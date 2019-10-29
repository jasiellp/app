import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/repository/usuario_repository.dart';
import 'package:food_ordering_app/screens/Conta/usuario_bloc.dart';
import 'package:food_ordering_app/screens/Conta/usuario_event.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';
import 'package:food_ordering_app/screens/EdicaoConta/index.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';

class Conta extends StatefulWidget {
  Conta({Key key}) : super(key: key);

  @override
  _ContaState createState() => new _ContaState();
}

TabController controller;

class _ContaState extends State<Conta> {
  final _usuarioBloc = UsuarioBloc(UsuarioRepository());
  Map usuario = Map();

  @override
  void initState() {

    _usuarioBloc.dispatch(GetUsuarioLogado());

  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
//          leading: new IconButton(
//              icon: new Icon(
//                Icons.chevron_left,
//                size: 40.0,
//                color: Theme.of(context).primaryColor,
//              ),
//              onPressed: () {
//                Navigator.of(context).pushReplacementNamed('/HomeWithTab');
//              }),
          centerTitle: true,
          title: new Text(
            "Conta",
            style: new TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: BlocListener(
          bloc: _usuarioBloc,
          listener: (context, state) {
            if (state is UsuarioInitial) {
              print('mensagem');
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.mensagem),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is UsuarioLoaded) {
              setState((){
                this.usuario = state.usuario;
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
              builder: (
                BuildContext context,
                UsuarioState state,
              ) {
                return Column(
                  children: <Widget>[
                    new Container(
                      child: new ListTile(
                        title: Text(
                          usuario['nome'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: new Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                usuario['email'] ?? '',
                                style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                usuario['celular'] ?? '',
                                style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        trailing: new IconButton(
                          icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EdicaoConta(
                                        usuario: usuario
                                      )));
                        },)
                      ),
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10.0, top: 3.0),
                    ),
                    new CustomCardConta(
                      icon: Icons.home,
                      text: 'Endereços',
                      trailingIcon: Icons.arrow_forward_ios,
                      route: '/Endereco',
                    ),
                    new CustomCardConta(
                      icon: Icons.payment,
                      text: 'Formas de Pagamento',
                      trailingIcon: Icons.arrow_forward_ios,
                      route: '/FormaPagamento',
                    ),
                    new CustomCardConta(
                        icon: Icons.help,
                        text: 'Ajuda',
                        trailingIcon: Icons.arrow_forward_ios,
                        route: '/Ajuda'),
                    new Container(
//            width: 20.0,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new InkWell(
                        onTap: () {
                          _usuarioBloc.dispatch(LogOffUsuario());
                          Navigator.of(context).pushReplacementNamed('/Home');
                        },
                        child: new Container(
                          child: const Text(
                            'Sair',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                          width: screenSize.width - 20,
                          height: 45.0,
//                margin: new EdgeInsets.only(
//                    top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                          alignment: FractionalOffset.center,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),

    );
  }
}

class CustomCardConta extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData trailingIcon;
  final String route;

  const CustomCardConta(
      {this.icon, this.text, this.trailingIcon, this.route});

  @override
  Widget build(BuildContext context) {
    return new Container(
//      color: Colors.white,
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: const BorderSide(
//              width: 0.3,
            color: Colors.black26,
          ))),
      child: new Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: new InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(route);
            },
            child: ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(
                    icon,
                    color: const Color.fromRGBO(153, 153, 153, 1.0),
                  ),
                  new Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: new Text(
                        text,
                        style: new TextStyle(
                            color: const Color.fromRGBO(68, 68, 68, 1.0),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              trailing: new Icon(
                trailingIcon,
                size: 20.0,
              ),
            )),
      ),
    );
  }
}
