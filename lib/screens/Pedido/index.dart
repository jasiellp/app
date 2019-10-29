//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//
//class Pedido extends StatefulWidget {
//  Pedido({Key key}) : super(key: key);
//
//  @override
//  _PedidoState createState() => new _PedidoState();
//}
//
//class _PedidoState extends State<Pedido> {
//
//
//  _PedidoState();
//
//  @override
//  Widget build(BuildContext context) {
//    final Size screenSize = MediaQuery.of(context).size;
//
//// final circular chart
//    return DefaultTabController(
//        length: 2,
//        child: Scaffold(
//      appBar: AppBar(
//        elevation: 0.0,
//        bottom: PreferredSize(child: TabBar(
//          indicatorColor: Colors.white,
//          indicatorPadding: const EdgeInsets.only(top: 1.0),
//          tabs: [
//            Tab(
//              child: Container(
//                child: Text(
//                  'ANTERIORES',
//                  style: TextStyle(fontSize: 15.0),
//                ),
//                margin: const EdgeInsets.only(top: 5.0),
//              ),
//            ),
//            Tab(
//              child: Container(
//                child: Text(
//                  'EM ANDAMENTO',
//                  style: TextStyle(fontSize: 15.0),
//                ),
//                margin: const EdgeInsets.only(top: 5.0),
//              ),
//            ),
//          ],
//        ), preferredSize: Size(10.0, 10.0)),
//        leading: IconButton(
//            icon: Icon(
//              Icons.chevron_left,
//              size: 40.0,
//              color: Theme.of(context).primaryColor,
//            ),
//            onPressed: () {
//              Navigator.of(context).pushReplacementNamed("/Cart");
//            }),
//        centerTitle: true,
//        title: Text(
//          "Pedidos",
//          style: TextStyle(
//              color: Theme.of(context).primaryColor,
//              fontWeight: FontWeight.w500,
//              fontSize: 16.0),
//        ),
//        backgroundColor: Colors.white,
//      ),
//
//
//      backgroundColor: Colors.white,
//      body: TabBarView(
//          children: [
//            Center(
//            child: SingleChildScrollView(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    "Por favor, faça o login para visualizar seus pedidos",
//                    textAlign: TextAlign.center,
//                    softWrap: true,
//                    style: TextStyle(
//                        color: Colors.black54,
//                        fontWeight: FontWeight.w400,
//                        letterSpacing: -0.1),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 50.0),
//                    child: InkWell(
//                      onTap: () {
//                        Navigator.of(context).pushNamed("/LoginTelefone");
//                      },
//                      child: Container(
//                        child: Text(
//                          defaultTargetPlatform == TargetPlatform.android
//                              ? "LOGIN"
//                              : "Login",
//                          style: const TextStyle(color: Colors.white, fontSize: 14.0),
//                        ),
//                        width: screenSize.width - 80,
//                        height: 45.0,
//                        alignment: FractionalOffset.center,
//                        decoration: BoxDecoration(
//                          color: Theme.of(context).primaryColor,
//                          borderRadius:
//                          const BorderRadius.all(const Radius.circular(5.0)),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//            Center(
//              child: SingleChildScrollView(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//
//                    Text(
//                      "Por favor, faça o login para visualizar seus pedidos",
//                      textAlign: TextAlign.center,
//                      softWrap: true,
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.w400,
//                          letterSpacing: -0.1),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 50.0),
//                      child: InkWell(
//                        onTap: () {
//                          Navigator.of(context).pushNamed("/PhoneNumber");
//                        },
//                        child: Container(
//                          child: Text(
//                            defaultTargetPlatform == TargetPlatform.android
//                                ? "LOGIN"
//                                : "Login",
//                            style: const TextStyle(color: Colors.white, fontSize: 14.0),
//                          ),
//                          width: screenSize.width - 80,
//                          height: 45.0,
//                          alignment: FractionalOffset.center,
//                          decoration: BoxDecoration(
//                            color: Theme.of(context).primaryColor,
//                            borderRadius:
//                            const BorderRadius.all(const Radius.circular(5.0)),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ]),
//    ));
//  }
//}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/AcompanhamentoPedido/acompanhamento_pedido_bloc.dart';
import 'package:food_ordering_app/screens/AcompanhamentoPedido/card_pedido.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';

class Pedido extends StatefulWidget {
  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  @override
  void initState() {
//    PedidosBloc bloc = PedidosBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.getBloc<LoginBloc>();
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Pedidos",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("pedidos")
                .where('usuario',
                    isEqualTo: _loginBloc.firebaseUser != null
                        ? _loginBloc.firebaseUser.uid
                        : "")
                .orderBy("data_criado", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                );


              if (_loginBloc.firebaseUser != null) {
                if (snapshot.data.documents.length == 0)
                  return Center(
                    child: Text(
                      "Nenhum pedido encontrado!",
                      style: TextStyle(color: Colors.red,fontSize: 20.0),
                    ),
                  );
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return CardPedido(snapshot.data.documents[index],index);
                    });
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Por favor, faça o login para visualizar seus pedidos",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/Login");
                            },
                            child: Container(
                              child: Text(
                                defaultTargetPlatform == TargetPlatform.android
                                    ? "LOGIN"
                                    : "Login",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              width: screenSize.width - 80,
                              height: 45.0,
                              alignment: FractionalOffset.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
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
              }
            }),
      ),
    );
  }
}
