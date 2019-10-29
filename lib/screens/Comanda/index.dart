import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/FormaPagamento/index.dart';
import 'package:food_ordering_app/screens/HomeWithTab/home_with_tab_bloc.dart'
    as globals;
import 'package:food_ordering_app/screens/Itens/index.dart';
import 'package:food_ordering_app/screens/LoginEmail/index.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;
import 'package:unique_identifier/unique_identifier.dart';
import 'comanda_bloc.dart';
import 'comanda_event.dart';
import 'comanda_state.dart';

class _ComandaState extends State<Comanda> {
  final MapEntry comanda;
  Map formaPagamento;
  final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
  bool _switchVal = false;
  String cpfAlterado ="";
  TextEditingController cpf = TextEditingController();

  _ComandaState({this.comanda});

  String identifier;


  @override
  void initState() {
    super.initState();

    UniqueIdentifier.serial.then((x){
      identifier = x;
    });

    BlocProvider.of<EnderecoBloc>(context).dispatch(GetEnderecoSelecionado());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _comandaBloc = BlocProvider.of<ComandaBloc>(context);

    return BlocListener(
        bloc: _comandaBloc,
        listener: (context, state) {
          if (state is ComandaFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ComandaEvent, ComandaState>(
            bloc: _comandaBloc,
            builder: (
              BuildContext context,
              ComandaState state,
            ) {
              if (state is ComandaLoaded) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    bottom: PreferredSize(
                      child: Container(
                        child: Padding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 100.0),
                                  child: InkWell(
                                      onTap: () async {
                                        var end = await Navigator.of(context).pushNamed("/Endereco");
                                        _comandaBloc.endereco = end;
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "ENTREGAR EM",
                                            style: new TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0),
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: Firestore.instance
                                                  .collection('enderecos').where('usuario',
                                                  isEqualTo: _loginBloc.firebaseUser == null
                                                      ? identifier : _loginBloc.firebaseUser.email)
                                                  .orderBy('selecionado', descending: true).snapshots(),
                                              builder: (context, snapshot) {

                                                if(!snapshot.hasData) {

                                                  return Container();
                                                }
                                                if(snapshot.data.documents.length>0){
                                                  _comandaBloc.endereco = snapshot.data.documents.first.data;
                                                }
                                                return Row(
                                                  children: <Widget>[

                                                    Text(
                                                      snapshot.data.documents.length ==
                                                          0 ?
                                                      "Informe um endereço"
                                                          : snapshot.data.documents.first.data['endereco'].toString() +
                                                          ' - ' +
                                                          snapshot.data.documents.first.data['numero'].toString(),
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 14.0),
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 15.0,
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                );
                                              })
                                        ],
                                      ))),
                            ],
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 5.0),
                      ),
                      preferredSize: new Size(screenSize.width, 50.0),
                    ),
                    title: new Text(
                      "Comanda",
                      style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: Colors.white,
                  body: new ListView(
                    controller: scrollController,
                    children: <Widget>[
                      new Container(
                        child: new Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: ImageIcon(
                                  ExactAssetImage(
                                      'assets/footer-menu/cart.png'),
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  globals.tabController.animateTo(0);
                                },
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150.0,
                                        child: Text(
                                          'Buffet (R\$ ${new NumberFormat("##0.00", "pt_BR").format(state.comanda.value['preco_kg']??0)}/kg)',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .display1,
                                        )),
                                    new Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: new Text(
                                        'Peso Total: ${state.comanda.value['peso_total']} g',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  child: Text(
                                'R\$ ${new NumberFormat("##0.00", "pt_BR").format(state.comanda.value['buffet_total'] ?? 0)}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 5.0),
                      ),
                      new Container(
                        height: 50.0,
                        margin: const EdgeInsets.only(top: 5.0, bottom: 1.0),
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 10.0),
                        color: Colors.white,
                        child: new Text(
                          'BEBIDAS / OUTROS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection('comanda')
                            .document(state.comanda.key)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return LinearProgressIndicator();
                          }
                          if (snapshot.data != null &&
                              snapshot.data['itens'] == null) {
                            return Container();
                          } else
                            return Container(
                              height: 60.0 * snapshot.data['itens'].length,
                              child: ListView.builder(
                                  itemCount: snapshot.data['itens'].length,
                                  itemBuilder: (context, int index) {
                                    return Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data['itens'][index]['nome'],
                                          style:
                                              const TextStyle(fontSize: 15.0),
                                        ),
                                        trailing: Container(
                                          width: 180.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    snapshot.data.data['itens']
                                                        [index]['quantidade']--;
                                                    var removendo = (snapshot
                                                                .data
                                                                .data['itens']
                                                            as List<dynamic>)
                                                        .where((x) =>
                                                            x['quantidade'] > 0)
                                                        .toList();
                                                    snapshot.data
                                                            .data['itens'] =
                                                        removendo;
                                                    Firestore.instance
                                                        .collection('comanda')
                                                        .document(
                                                            state.comanda.key)
                                                        .setData(
                                                            snapshot.data.data,
                                                            merge: true);
                                                    BlocProvider.of<
                                                                ComandaBloc>(
                                                            context)
                                                        .comandaRepository
                                                        .updateItem(MapEntry(
                                                            snapshot.data
                                                                .documentID,
                                                            snapshot
                                                                .data.data));
                                                  }),
                                              Text(
                                                snapshot.data['itens'][index]
                                                            ['quantidade'] <
                                                        10
                                                    ? '0' +
                                                        snapshot.data['itens']
                                                                    [index]
                                                                ['quantidade']
                                                            .toString()
                                                    : snapshot.data['itens']
                                                                [index]
                                                            ['quantidade']
                                                        .toString(),
                                                style: defaultTargetPlatform ==
                                                        TargetPlatform.iOS
                                                    ? TextStyle(
                                                        fontWeight: FontWeight
                                                            .w100,
                                                        color: const Color
                                                                .fromRGBO(
                                                            153, 153, 153, 1.0))
                                                    : TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color
                                                                .fromRGBO(153,
                                                            153, 153, 1.0)),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    snapshot.data.data['itens']
                                                        [index]['quantidade']++;
                                                    Firestore.instance
                                                        .collection('comanda')
                                                        .document(
                                                            state.comanda.key)
                                                        .setData(
                                                            snapshot.data.data,
                                                            merge: true);
                                                    BlocProvider.of<
                                                                ComandaBloc>(
                                                            context)
                                                        .comandaRepository
                                                        .updateItem(MapEntry(
                                                            snapshot.data
                                                                .documentID,
                                                            snapshot
                                                                .data.data));
                                                  }),
                                              Text(
                                                  'R\$ ' +
                                                      (new NumberFormat(
                                                                  "##0.00",
                                                                  "pt_BR")
                                                              .format(snapshot.data['itens']
                                                                          [index]
                                                                      [
                                                                      'preco'] *
                                                                  snapshot.data['itens']
                                                                          [index]
                                                                      [
                                                                      'quantidade']))
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                        },
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey[100],
                              ),
                              bottom: BorderSide(
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: InkWell(
                              onTap: () async {
                                var item = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Itens()));
                                if (item != null) {
                                  item['quantidade'] = 1;
                                  var aux = List<dynamic>();
                                  bool atualizado = false;
                                  DocumentSnapshot existente = await Firestore
                                      .instance
                                      .collection('comanda')
                                      .document(state.comanda.key)
                                      .get();

                                  if (existente.data['itens'] != null) {
                                    existente.data['itens'].forEach((x) {
                                      if (item['nome'] == x['nome']) {
                                        x['quantidade']++;
                                        atualizado = true;
                                      }
                                      aux.add(x);
                                    });
                                    if (!atualizado) {
                                      aux.add(item);
                                    }
                                    existente.data['itens'] = aux;
                                  }
                                  Firestore.instance
                                      .collection('comanda')
                                      .document(state.comanda.key)
                                      .setData(existente.data, merge: true);
                                }
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Adicionar mais itens',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400))))),
                      StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection('comanda')
                              .document(state.comanda.key)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Subtotal',
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1.0)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'R\$ ${new NumberFormat("##0.00", "pt_BR").format(snapshot.data.data['subtotal'])}',
                                              style: const TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Embalagem ${snapshot.data.data['descricao_embalagem']}",
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1.0)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'R\$ ${new NumberFormat("##0.00", "pt_BR").format(snapshot.data.data['valor_embalagem'])}',
                                              style: const TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Taxa de entrega',
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1.0)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'R\$ ${new NumberFormat("##0.00", "pt_BR").format(snapshot.data.data['entrega'])}',
                                              style: const TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Total',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'R\$ ${new NumberFormat("##0.00", "pt_BR").format(snapshot.data.data['subtotal'] + snapshot.data.data['entrega'])}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 10.0),
                                  color: Colors.white,
                                  child: new Text(
                                    'PAGAMENTO',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  leading: formaPagamento != null
                                      ? Image.network(
                                          formaPagamento['icone'].toString())
                                      : null,
                                  title: Text(
                                    formaPagamento != null
                                        ? formaPagamento['descricao']
                                        : 'Ainda não selecionado',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: formaPagamento != null
                                      ? Text(formaPagamento['observacao'])
                                      : null,
                                  trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Payments()))
                                            .then((response) {
                                          setState(() {
                                            formaPagamento = response;
                                          });
                                        });
                                      },
                                      child: Text(
                                        formaPagamento == null
                                            ? 'Selecionar'
                                            : 'Trocar',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                        .collection('usuarios')
                                        .document(_loginBloc.firebaseUser?.uid)
                                        .get()
                                        .asStream(),
                                  builder: (context, snapshot) {
                                    cpf = TextEditingController(text: snapshot.hasData && snapshot.data != null && snapshot.data.data != null ? snapshot.data.data['cpf_cnpj']: '');
                                    return Column(
                                      children: <Widget>[
                                        new Container(
                                            decoration: border,
                                            padding: new EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: <Widget>[

                                                      Text(
                                                        'CPF/CNPJ na nota',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Switch(
                                                        value: _switchVal,
                                                        activeColor: Colors.red,
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            this._switchVal = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 150.0,
                                                  child: new TextFormField(
                                                    textAlign: TextAlign.end,
                                                    //initialValue: snapshot.hasData && snapshot.data != null && snapshot.data.data != null ? snapshot.data.data['cpf_cnpj']: '',
                                                    controller: cpf,
                                                    decoration: inputDecoration,
                                                    focusNode: FocusNode(),
                                                    keyboardType: TextInputType.numberWithOptions(),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: RaisedButton(
                                    color: Colors.red,
                                    disabledColor: Colors.grey,
                                    onPressed: formaPagamento == null ||
                                            state.comanda.value['peso_total'] ==
                                                0
                                        ? null
                                        : () async {
                                            snapshot.data
                                                    .data['forma_pagamento'] =
                                                formaPagamento;
                                            snapshot.data.data['fechado'] =
                                                true;
                                            var logado =
                                                _loginBloc.firebaseUser;
                                            if (logado == null) {
                                              logado = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            }
                                            if (logado != null) {
                                              QuerySnapshot querySnapshot =
                                              await Firestore.instance.collection('enderecos').where('usuario', isEqualTo: identifier).getDocuments();

                                              if (querySnapshot.documents.length > 0) {

                                                querySnapshot.documents.forEach((x) async {
                                                  x.data['usuario'] = logado.email;
                                                  await Firestore.instance.collection('enderecos').document(x.documentID).setData(x.data,merge: true);
                                                });
                                              }
                                              snapshot.data.data['usuario'] =
                                                  logado.uid;
                                              snapshot.data.data[
                                                      'endereco_entrega'] =
                                                  _comandaBloc.endereco;
                                              Firestore.instance
                                                  .collection('comanda')
                                                  .document(state.comanda.key)
                                                  .setData(snapshot.data.data,
                                                      merge: true);
                                              Map<String, dynamic> pedido = {};
                                              pedido['data_criado'] =
                                                  DateTime.now();
                                              pedido['usuario'] =
                                                  _loginBloc.firebaseUser.uid;
                                              pedido['comanda'] =
                                                  snapshot.data.data;
                                              Map<String, dynamic> status = {};
                                              status['status_id'] = 0;
                                              status['status'] =
                                                  'Pedido Criado';
                                              pedido['status'] = status;
                                              pedido['endereco_entrega'] =
                                                  _comandaBloc.endereco;
                                              if(_switchVal) {
                                                pedido['cpf_cnpj'] = cpf.value.text;
                                              }
                                              var pedidoGerado = await Firestore
                                                  .instance
                                                  .collection('pedidos')
                                                  .add(pedido);
                                              _comandaBloc
                                                  .dispatch(GetComanda());
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Pedido \n ${pedidoGerado.documentID} \n gerado com sucesso!"),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          child: Text('Fechar'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        new FlatButton(
                                                          child: Text(
                                                              'Acompanhar pedido'),
                                                          onPressed: () {
                                                            globals
                                                                .tabController
                                                                .animateTo(2);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(context).pushNamed(
                                                                '/AcompanhamentoPedido',
                                                                arguments:
                                                                    pedidoGerado
                                                                        .documentID);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                              globals.tabController
                                                  .animateTo(2);
                                            }
                                          },
                                    child: Container(
                                      child: Text(
                                        _loginBloc.firebaseUser == null
                                            ? defaultTargetPlatform ==
                                                    TargetPlatform.android
                                                ? 'LOGIN'
                                                : 'Login'
                                            : defaultTargetPlatform ==
                                                    TargetPlatform.android
                                                ? 'FECHAR COMANDA'
                                                : 'Fechar Comanda',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      width: screenSize.width - 20,
                                      height: 45.0,
                                      alignment: FractionalOffset.center,
                                      decoration: const BoxDecoration(
//                              color: Colors.red,
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            }));
  }
}

FocusNode _myNode = new FocusNode()..addListener(listener);
ScrollController scrollController = new ScrollController(
  initialScrollOffset: 0.0,
  keepScrollOffset: true,
);

Size screenSize;

class Comanda extends StatefulWidget {
  final MapEntry comanda;

  Comanda({Key key, this.comanda}) : super(key: key);

  @override
  _ComandaState createState() => new _ComandaState(comanda: this.comanda);
}

listener() {
  if (_myNode.hasFocus) {
    // keyboard appeared
    scrollController.animateTo(
      1000.0,
//      1 * screenSize.height / 2,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 400),
    );
  } else {
    // keyboard dismissed
  }
}
