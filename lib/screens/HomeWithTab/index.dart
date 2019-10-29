import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/repository/buffet_repository.dart';
import 'package:food_ordering_app/repository/comanda_repository.dart';
import 'package:food_ordering_app/repository/endereco_repository.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_bloc.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_event.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/HomeWithTab/home_with_tab_bloc.dart' as globals;
import 'package:food_ordering_app/screens/Buffet/buffet_bloc.dart';
import 'package:food_ordering_app/screens/Buffet/buffet_event.dart';
import 'package:food_ordering_app/screens/Buffet/buffet_state.dart';

import 'package:food_ordering_app/screens/HomeWithTab/style.dart';

import 'package:food_ordering_app/screens/Comanda/index.dart' as Comanda;
import 'package:food_ordering_app/screens/Conta/index.dart' as Conta;
import 'package:food_ordering_app/screens/Pedido/index.dart' as Pedido;
import 'package:food_ordering_app/screens/Buffet/index.dart' as Home;
import 'package:food_ordering_app/screens/Raspadinha/index.dart' as Raspadinha;

class HomeWithTab extends StatefulWidget {
  HomeWithTab({Key key}) : super(key: key);

  @override
  _HomeWithTabState createState() => new _HomeWithTabState();
}

class _HomeWithTabState extends State<HomeWithTab> {
  final buffetRepository = BuffetRepository();
  final comandaRepository = ComandaRepository();
  final enderecoRepository = EnderecoRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(blocProviders: [
      BlocProvider<BuffetBloc>(builder: (context) {
        return BuffetBloc(
          buffetRepository,
        );
      }),
      BlocProvider<ComandaBloc>(builder: (context) {
        return ComandaBloc(
          comandaRepository,
        );
      }),
      BlocProvider<EnderecoBloc>(builder: (context) {
        return EnderecoBloc(
          enderecoRepository,
        );
      })
    ], child: HomeWithTabSub());
  }
}

class HomeWithTabSub extends StatefulWidget {
  HomeWithTabSub({Key key}) : super(key: key);

  @override
  _HomeWithTabSubState createState() => new _HomeWithTabSubState();
}

TabController controller;

class _HomeWithTabSubState extends State<HomeWithTabSub>
    with TickerProviderStateMixin {
  @override
  void initState() {
    controller = new TabController(length: 5, vsync: this);
    globals.tabController = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final buffetRepository = BuffetRepository();
    final comandaRepository = ComandaRepository();
    final enderecoRepository = EnderecoRepository();
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<BuffetBloc>(builder: (context) {
            return BuffetBloc(
              buffetRepository,
            )..dispatch(GetBuffet());
          }),
          BlocProvider<ComandaBloc>(builder: (context) {
            return ComandaBloc(
              comandaRepository,
            )..dispatch(GetComanda());
          }),
          BlocProvider<EnderecoBloc>(builder: (context) {
            return EnderecoBloc(
              enderecoRepository,
            );
          })
        ],
        child: BlocBuilder<BuffetEvent, BuffetState>(
            bloc: BlocProvider.of<BuffetBloc>(context),
            builder: (
              BuildContext context,
              BuffetState state,
            ) {
              return Scaffold(
                primary: true,
                resizeToAvoidBottomPadding: false,
                backgroundColor: Color.fromRGBO(246, 246, 246, 1.0),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Home.Home(),
                    Comanda.Comanda(),
                    Raspadinha.Raspadinha(),
                    Pedido.Pedido(),
                    Conta.Conta()
                  ],
                  controller: controller,
                ),

                bottomNavigationBar: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: TabBar(
                    tabs: <Tab>[
                      Tab(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              cart,
                              size: 30.0,
                            ),
                            Text(
                              "Buffet",
                              style: TextStyle(fontSize: 11.0),
                            )
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              order,
                              size: 30.0,
                            ),
                            Text("Comanda",
                            style: TextStyle(fontSize: 11.0),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              order,
                              size: 30.0,
                            ),
                            Text("Sorteio",
                            style: TextStyle(fontSize: 11.0),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              size: 30.0,
                            ),
                            Text("Pedidos",
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              account,
                              size: 30.0,
                            ),
                            Text("Perfil",
                            style: TextStyle(fontSize: 11.0),
                      ),
                          ],
                        ),
                      ),
                    ],
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white30,
                    controller: controller,
                    labelStyle: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              );
            }));
  }
}
