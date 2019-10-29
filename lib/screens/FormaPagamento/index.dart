import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/repository/forma_pagamento_repository.dart';
import 'package:food_ordering_app/screens/FormaPagamento/forma_pagamento_bloc.dart';
import 'package:food_ordering_app/screens/FormaPagamento/forma_pagamento_event.dart';
import 'package:food_ordering_app/screens/FormaPagamento/forma_pagamento_state.dart';

class Payments extends StatefulWidget {
  Payments({Key key}) : super(key: key);

  @override
  _PaymentsState createState() => new _PaymentsState();
}

TabController controller;

class _PaymentsState extends State<Payments> {
  List<Map> formasPagamento = List<Map>();
  final _formaPagamentoBloc = FormaPagamentoBloc(FormaPagamentoRepository());

  @override
  void initState() {
    _formaPagamentoBloc.dispatch(GetFormasPagamento());
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
            "Forma de Pagamento",
            style: new TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocListener(
            bloc: _formaPagamentoBloc,
            listener: (context, state) {
              if (state is FormaPagamentoInitial) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.mensagem),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state is FormasPagamentoLoaded) {
                setState(() {
                  this.formasPagamento = state.formasPagamento;
                });
              }
              if (state is FormaPagamentoFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<FormaPagamentoEvent, FormaPagamentoState>(
                bloc: _formaPagamentoBloc,
                builder: (
                  BuildContext context,
                  FormaPagamentoState state,
                ) {
                  return ListView.builder(
                    itemCount: formasPagamento.length,
                    itemBuilder: (_, int index) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                Navigator.pop(context, formasPagamento[index]);

                              },
                              child: ListTile(
                                dense: true,
                                leading: Image.network(
                                    formasPagamento[index]['icone'].toString(),
                                width: 90.0,
                                height: 50.0,),
                                title: Text(
                                  formasPagamento[index]['descricao'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    formasPagamento[index]['observacao'] ?? ''),
                              )),
                          Divider(),
                        ],
                      );
                    },
                  );
                })));
  }
}
