import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/repository/itens_repository.dart';
import 'package:food_ordering_app/screens/Conta/usuario_state.dart';
import 'package:food_ordering_app/screens/Itens/itens_bloc.dart';
import 'package:food_ordering_app/screens/Itens/itens_event.dart';
import 'package:food_ordering_app/screens/Itens/itens_state.dart';
import 'package:intl/intl.dart';

import 'itens_bloc.dart';
import 'itens_event.dart';

class Itens extends StatefulWidget {
  Itens({Key key}) : super(key: key);

  @override
  _ItensState createState() => new _ItensState();
}

class _ItensState extends State<Itens> {
  final _itensBloc = ItensBloc(ItensRepository());
  List<Map> itens = List<Map>();

  _ItensState();

  @override
  void initState() {
    _itensBloc.dispatch(GetItens());
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
            "Bebidas / Sobremesas",
            style: new TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocListener(
          bloc: _itensBloc,
          listener: (context, state) {
            if (state is ItensInitial) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.mensagem),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is ItensLoaded) {
              setState(() {
                this.itens = state.itens;
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
          child: BlocBuilder<ItensEvent, ItensState>(
              bloc: _itensBloc,
              builder: (
                BuildContext context,
                ItensState state,
              ) {
                return ListView.builder(
                  itemCount: itens.length,
                  itemBuilder: (_, int index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.pop(context, itens[index]);
                            },
                            child: ListTile(
                              dense: true,
                            leading: Image.network(
                                itens[index]['imagem']),
                              title: Text(
                                itens[index]['nome'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),

                              ),
                              subtitle:
                                  Text('R\$ ${new NumberFormat("##0.00#", "pt_BR").format(itens[index]['preco'])}' ?? ''),
                            )),
                        Divider(),
                      ],
                    );
                  },
                );
              }),
        ));
  }
}
