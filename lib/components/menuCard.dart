import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/menuCardData.dart';
import 'package:food_ordering_app/theme/style.dart';

class MenuCardBuilder extends StatefulWidget {
  final List<menuCardData> cards;

  const MenuCardBuilder({this.cards});

  @override
  MenuCardBuilderState createState() => new MenuCardBuilderState(cards: cards);
}

class MenuCardBuilderState extends State<MenuCardBuilder> {
  final List<menuCardData> cards;

  MenuCardBuilderState({this.cards});

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: cards.map((menuCardData menuCardData) {
      return new Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Card(
          child: new Column(
            children: <Widget>[
              new Image(
                image: new ExactAssetImage(menuCardData.image),
                fit: BoxFit.cover,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 13.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.only(right: 5.0),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                menuCardData.veg ? Colors.green : Colors.red)),
                    new Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: new Text(menuCardData.dishName,
                          style: new TextStyle(
                              color: const Color.fromRGBO(68, 68, 68, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4)),
                    ),
                  ],
                ),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left: 15.0),
                      child: new Text(
                        'Rs. ' + menuCardData.amount,
                        style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(
                              Icons.remove_circle_outline,
                              color: Colors.lightBlue[700],
                              size: 22.0,
                            ),
                            iconSize: 18.0,
                            onPressed: () {
                              setState(() {
                                if (menuCardData.quantity > 0) {
                                  menuCardData.quantity--;
                                }
                              });
                            }),
                        new Text(
                          '0' + menuCardData.quantity.toString(),
                          style: textStyle10normal,
                        ),
                        new IconButton(
                            icon: new Icon(
                              Icons.add_circle_outline,
                              color: Colors.lightBlue[700],
                              size: 22.0,
                            ),
                            iconSize: 18.0,
                            onPressed: () {
                              setState(() {
                                menuCardData.quantity++;
                              });
                            }),
                      ],
                    ),
                  ]),
            ],
          ),
        ),
      );
    }).toList());
  }
}
