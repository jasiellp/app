//import 'package:bloc_pattern/bloc_pattern.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:food_ordering_app/screens/AcompanhamentoPedido/acompanhamento_pedido_bloc.dart';
//import 'package:food_ordering_app/screens/AcompanhamentoPedido/card_pedido.dart';
//import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
//import 'scratch_box.dart';
//import 'advanced.dart';
//import 'basic.dart';
//
//class Raspadinha extends StatefulWidget {
//  @override
//  _RaspadinhaState createState() => _RaspadinhaState();
//}
//
//class _RaspadinhaState extends State<Raspadinha> {
//  @override
//  void initState() {
////    RaspadinhasBloc bloc = RaspadinhasBloc();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final _loginBloc = BlocProvider.getBloc<LoginBloc>();
//    Size screenSize = MediaQuery.of(context).size;
//
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0.0,
//        centerTitle: true,
//        title: Text(
//          "Sorteio",
//          style: TextStyle(
//              color: Theme.of(context).primaryColor,
//              fontWeight: FontWeight.w500,
//              fontSize: 16.0),
//        ),
//        backgroundColor: Colors.white,
//      ),
//      backgroundColor: Colors.white,
//      body: TabBarView(
//        physics: const NeverScrollableScrollPhysics(),
//        children: [
//          AdvancedScreen(),
//          BasicScreen(),
//        ],
//      ),
//      ),
//    );
//  }
//}
import 'package:flutter/material.dart';
import 'package:food_ordering_app/scratch_box.dart';
//import 'package:food_ordering_app/lib/scratch_box.dart';
//import 'lib/scratch_box.dart';
//import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';


const googleIcon = 'assets/Raspadinha/google.png';
const dartIcon = 'assets/Raspadinha/dart.png';
const flutterIcon = 'assets/Raspadinha/flutter.png';

class Raspadinha extends StatefulWidget {
  @override
  _RaspadinhaState createState() => _RaspadinhaState();
}

class _RaspadinhaState extends State<Raspadinha>
    with SingleTickerProviderStateMixin {
  double validScratches = 0;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
      ..addStatusListener(
            (listener) {
          if (listener == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      );
    _animation = Tween(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'RASPADINHA',
                  style: TextStyle(
                    fontFamily: 'fontello',
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ache três logos, iguais e seguidos e ganhe um presente |',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 1,
                  width: 200,
                  color: Colors.black12,
                )
              ],
            ),
            buildRow(googleIcon, dartIcon, googleIcon),
            buildRow(flutterIcon, dartIcon, googleIcon),
            buildRow(flutterIcon, dartIcon, dartIcon),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String left, String center, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScratchBox(image: left),
        ScratchBox(
          image: center,
          animation: _animation,
          onScratch: () {
            setState(() {
              validScratches++;
              if (validScratches == 3) {
                _animationController.forward();
              }
            });
          },
        ),
        ScratchBox(image: right),
      ],
    );
  }
}
