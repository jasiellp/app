import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_bloc.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_state.dart';
import 'package:food_ordering_app/screens/Buffet/pager.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_state.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:intl/intl.dart';
import 'package:food_ordering_app/screens/HomeWithTab/home_with_tab_bloc.dart'
as globals;
import 'package:unique_identifier/unique_identifier.dart';
import 'buffet_bloc.dart';
import 'buffet_event.dart';
import 'buffet_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;

class Home extends StatefulWidget {
  final MapEntry buffet;

  Home({this.buffet});

  @override
  _HomeState createState() => _HomeState(buffet: this.buffet);
}

const double _kViewportFraction = 0.75;

class _HomeState extends State<Home> {
  final MapEntry buffet;
  int peso = 0;
  List<MapEntry> pratos = [];
  final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
  final PageController pageController =
  new PageController(viewportFraction: _kViewportFraction);

  String identifier;


  _HomeState({this.buffet});

  @override
  void initState() {
    super.initState();

    UniqueIdentifier.serial.then((x){
      identifier = x;
    });

    BlocProvider.of<EnderecoBloc>(context).dispatch(GetEnderecoSelecionado());
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    final _comandaBloc = BlocProvider.of<ComandaBloc>(context);
    final _buffetBloc = BlocProvider.of<BuffetBloc>(context);
    final _enderecoBloc = BlocProvider.of<EnderecoBloc>(context);
    Map args = ModalRoute
        .of(context)
        .settings
        .arguments;
    _comandaBloc.endereco = args;
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return BlocListener(
        bloc: _comandaBloc,
        listener: (context, state) {
          if (state is ComandaLoaded) {
            _comandaBloc.comanda = state.comanda;
          }
        },
        child: BlocListener(

            bloc: _buffetBloc,
            listener: (context, state) {
              if (state is BuffetFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<BuffetEvent, BuffetState>(
                bloc: _buffetBloc,
                builder: (BuildContext context,
                    BuffetState state,) {
                  if (state is BuffetLoaded) {
                    return Scaffold(
                        resizeToAvoidBottomPadding: false,
                        backgroundColor: Theme
                            .of(context)
                            .backgroundColor,
                        appBar: PreferredSize(
                          preferredSize: Size(screenSize.width, 215.0),
                          child: AppBar(
                            bottom: PreferredSize(
                                preferredSize: Size(screenSize.width, 10.0),
                                child: SizedBox(
                                  height: screenSize.height / 5,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        height: screenSize.height / 4,
                                        width: screenSize.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                  height: 100.0,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    itemCount: state
                                                        .buffet
                                                        .value['pratos_list']
                                                        .length,
                                                    itemBuilder:
                                                        (_, int index) =>
                                                        Container(
                                                          child: FlatButton(
                                                            onPressed: () {
                                                              if (pageController
                                                                  .hasClients) {
                                                                pageController
                                                                    .animateToPage(
                                                                    index,
                                                                    duration: Duration(
                                                                        milliseconds: 175),
                                                                    curve: Curves
                                                                        .easeOut);
                                                              }
                                                            },
                                                            child: Image.asset(
                                                              state
                                                                  .buffet
                                                                  .value['pratos_list']
                                                              [index]
                                                                  .value['imagem'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                  )),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )),
                            elevation: 0.0,
                            leading: Icon(
                              Icons.location_on,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),

                            title: InkWell(
                                onTap: () async {
                                  await Navigator.of(context)
                                      .pushNamed("/Endereco");

                                  _enderecoBloc.dispatch(GetEnderecoSelecionado());
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "ENTREGAR EM",
                                          style: TextStyle(
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
                            actions: <Widget>[

                              StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                      .collection('comanda')
                                      .document(_comandaBloc.comanda.key)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, right: 5.0),
                                      child: InkWell(
                                        onTap: () {
                                          globals.tabController.animateTo(1);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${snapshot.hasData ?
                                              (snapshot.data.data != null
                                                  ? snapshot.data
                                                  .data['peso_total'] > 999
                                                  ? snapshot.data
                                                  .data['peso_total'] / 1000
                                                  :
                                              snapshot.data.data['peso_total']
                                                  : '0') : '0'} " +
                                                  (snapshot.hasData &&
                                                      snapshot.data.data !=
                                                          null && snapshot.data
                                                      .data['peso_total'] > 999
                                                      ? 'kg'
                                                      : 'g'),
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              "R\$ ${snapshot.hasData
                                                  ?
                                              (snapshot.data.data != null ?
                                              NumberFormat("##0.00", "pt_BR")
                                                  .format(snapshot.data
                                                  .data['subtotal']) : '0,00')
                                                  : '0,00'}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],),
                                      ),
                                    );
                                  }
                              ),
                            ],
                            brightness:
                            Theme
                                .of(context)
                                .primaryColorBrightness,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        body: MenuPager(pageController));
                  }

                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                  );
                }))

    );
  }
}

class ScreenArguments {
  final String peso;

  ScreenArguments(this.peso);
}
