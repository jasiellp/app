import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/model/background_colors.dart';
import 'package:food_ordering_app/model/menu.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_bloc.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_event.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_state.dart';
import 'package:food_ordering_app/widgets/animated_circle.dart';
import 'package:food_ordering_app/widgets/food_image.dart';
import 'package:food_ordering_app/widgets/item_card.dart';
import 'package:food_ordering_app/widgets/shadows.dart';

import 'buffet_bloc.dart';
import 'buffet_event.dart';
import 'buffet_state.dart';

class MenuPager extends StatefulWidget {
  final PageController pageController;
  MenuPager(this.pageController);

  @override
  _MenuPagerState createState() => new _MenuPagerState();
}



class _MenuPagerState extends State<MenuPager> with TickerProviderStateMixin {

  final PageController _backgroundPageController = new PageController();

  ValueNotifier<double> selectedIndex = new ValueNotifier<double>(0.0);
  Color _backColor = const Color.fromRGBO(240, 232, 223, 1.0);
  int _counter = 0;
  int _cartQuantity = 0;
  AnimationController controller, scaleController;
  Animation<double> scaleAnimation;
  bool firstEntry = true;
  MapEntry comanda;
  List<MapEntry> pratos = [];

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    scaleController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 175));
    scaleAnimation = new Tween<double>(begin: 1.0, end: 1.20).animate(
        new CurvedAnimation(parent: scaleController, curve: Curves.easeOut));

  }

  @override
  void dispose() {
    controller.dispose();
    scaleController.dispose();
    widget.pageController.dispose();
    _backgroundPageController.dispose();
    super.dispose();
  }

  _contentWidget(
      MapEntry buffet, int index, Alignment alignment, double resize) {
    final _comandaBloc = BlocProvider.of<ComandaBloc>(context);

    return BlocBuilder<ComandaEvent, ComandaState>(
        bloc: _comandaBloc,
        builder: (
          BuildContext context,
          ComandaState state,
        ) {


//          print(state);

          if(state is ComandaLoaded){
            return Stack(
              alignment: alignment,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 300.0 * resize,
                    height: 320.0 * resize,
                    child: Stack(
                      children: <Widget>[
                        shadow1,
                        ItemCard(
                          food: buffet.value['pratos_list'][index],
                          increment: () {
                            setState(() {
                              buffet.value['pratos_list'][index].value['quantidade'] != null
                                  ? buffet.value['pratos_list'][index].value['quantidade']++
                                  : buffet.value['pratos_list'][index].value['quantidade'] = 1;

                              state.comanda.value['buffet'] = buffet.value['pratos_list'];
                              state.comanda.value['preco_kg'] = buffet.value['preco_kg'];
                            });

                            _comandaBloc.dispatch(
                                ChangeFoodItemPressed(comanda: state.comanda));
                          },
                          decrement: () {
                            setState(() {
                              buffet.value['pratos_list'][index].value['quantidade']--;

                              state.comanda.value['buffet'] = buffet.value['pratos_list'];
                            });

                            _comandaBloc.dispatch(
                                ChangeFoodItemPressed(comanda: state.comanda));
                          },
                        ),
                        FoodImage(food: buffet.value['pratos_list'][index]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Container();

        });
  }

  Iterable<Widget> _buildPages(MapEntry buffet) {
    final List<Widget> pages = <Widget>[];
    for (int index = 0; index < buffet.value['pratos_list'].length; index++) {
      var alignment = Alignment.center.add(new Alignment(
          (selectedIndex.value - index) * 0.75, 0.0));
      var resizeFactor =
          (1 - (((selectedIndex.value - index).abs() * 0.2).clamp(0.0, 1.0)));
      pages.add(_contentWidget(
        buffet,
        index,
        alignment,
        resizeFactor,
      ));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    var _buffetBloc = BlocProvider.of<BuffetBloc>(context);
    timeDilation = 1.0;
    return BlocListener(
        bloc: BlocProvider.of<ComandaBloc>(context),
        listener: (context, state) {
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
                builder: (
                  BuildContext context,
                  BuffetState state,
                ) {
                  if (state is BuffetLoaded) {
                    return Stack(
                      children: <Widget>[
                        PageView.builder(
                          itemCount: Menu.menu.length,
                          itemBuilder: (BuildContext context, int itemCount) {
                            return Container();
                          },
                          controller: _backgroundPageController,
                          onPageChanged: (index) {
                            setState(() {
                              _backColor = colors[
                                  math.Random().nextInt(colors.length)];
                            });
                          },
                        ),
                        NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                            if (notification.depth == 0 &&
                                notification is ScrollUpdateNotification) {
                              selectedIndex.value = widget.pageController.page;
                              if (_backgroundPageController.page !=
                                  widget.pageController.page) {
                                _backgroundPageController.position
                                    .jumpToWithoutSettling(
                                    widget.pageController.position.pixels /
                                            0.75);
                              }
                            }
                            return false;
                          },
                          child: PageView(
                            controller: widget.pageController,
                            children:
                                _buildPages(state.buffet),
                          ),
                        ),
                        Positioned.fill(
                          top: 30.0,
                          right: 5.0,
                          bottom: 100.0,
                          child:
                              StaggerAnimation(controller: controller.view),
                        ),
                        firstEntry
                            ? Container()
                            : Align(
                                alignment: Alignment.topRight,
                                child: ScaleTransition(
                                  scale: scaleAnimation,
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(top: 30.0, right: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.amber),
                                    child: Text('$_cartQuantity',
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0)),
                                  ),
                                ),
                              ),
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })));
  }
}
