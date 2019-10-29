import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/AcompanhamentoPedido/acompanhamento_pedido_bloc.dart';
import 'package:food_ordering_app/screens/AcompanhamentoPedido/acompanhamento_pedido_detalhe.dart';
import 'package:food_ordering_app/screens/Ajuda/index.dart';
import 'package:food_ordering_app/screens/Comanda/index.dart';
import 'package:food_ordering_app/screens/Conta/index.dart';
import 'package:food_ordering_app/screens/EdicaoConta/index.dart';
import 'package:food_ordering_app/screens/Endereco/index.dart';
import 'package:food_ordering_app/screens/Favorito/index.dart';
import 'package:food_ordering_app/screens/Filtro/index.dart';
import 'package:food_ordering_app/screens/FormaPagamento/index.dart';
import 'package:food_ordering_app/screens/HomeWithTab/index.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/index.dart';
import 'package:food_ordering_app/screens/Itens/index.dart';
import 'package:food_ordering_app/screens/Localizacao/index.dart';
import 'package:food_ordering_app/screens/Home/index.dart';
import 'package:food_ordering_app/screens/LoginEmail/index.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:food_ordering_app/screens/LoginTelefone/index.dart';
import 'package:food_ordering_app/screens/Pedido/index.dart';
import 'package:food_ordering_app/screens/Registro/registro_module.dart';
import 'package:food_ordering_app/screens/SplashScreen/index.dart';
import 'package:food_ordering_app/screens/WesternFoodMenu/index.dart';
import 'package:food_ordering_app/theme/style.dart';
import 'package:food_ordering_app/screens/Raspadinha/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => PedidosBloc()),
        Bloc((i)=> LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.red,
        home: const SplashScreen(),
        routes: routes,
        theme: appTheme,
      ),
    );
  }

  var routes = <String, WidgetBuilder>{
    '/Login': (BuildContext context) => Login(),
    '/Registro': (BuildContext context) => RegistroModule(),
    '/Home': (BuildContext context) => Home(),
    '/Endereco': (BuildContext context) => new Endereco(),
    '/Conta': (BuildContext context) => new Conta(),
    '/EdicaoConta': (BuildContext context) => new EdicaoConta(),
    '/Itens': (BuildContext context) => new Itens(),
    '/Pedido': (BuildContext context) => new Pedido(),
    '/AcompanhamentoPedido': (BuildContext context) =>new AcompanhamentoPedido(),
    '/Ajuda': (BuildContext context) => new Help(),
    '/FormaPagamento': (BuildContext context) => new Payments(),
    '/Localizacao': (BuildContext context) => new LocationScreen(),
    '/Favorito': (BuildContext context) => const Favourites(),
    '/HomeWithTab': (BuildContext context) => new HomeWithTab(),
    '/Comanda': (BuildContext context) => new Comanda(),
    '/LoginTelefone': (BuildContext context) => new PhoneNumber(),
    '/IndianFoodMenu': (BuildContext context) => const IndianFoodMenu(),
    '/WesternFoodMenu': (BuildContext context) => const WesternFoodMenu(),
    '/Filtro': (BuildContext context) => new Filter(),
    '/SplashScreen': (BuildContext context) => const SplashScreen(),
    '/Raspadinha': (BuildContext context) => new Raspadinha(),
  };
}
