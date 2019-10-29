import 'package:flutter/material.dart';
import 'package:food_ordering_app/model/food.dart';
import 'dart:math' as math;

class ItemCard extends StatelessWidget {
  const ItemCard({this.food, this.increment, this.decrement});

  final MapEntry food;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: new Card(
          elevation: 3.0,
          child: new Container(
            height: math.min(300.0, MediaQuery.of(context).size.height),
            child: new Container(
              margin: const EdgeInsets.only(top: 80.0, bottom: 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(food.value["nome"],
                      style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Dosis')),
                  new Text('${food.value["peso"]} g por porção',
                      style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Dosis')),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.remove),
                          onPressed: food.value["quantidade"] == null || food.value["quantidade"] == 0 ? null : decrement,
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            border: new Border.all(
                              color: Colors.grey[700],
                              width: 0.5,
                            ),
                          ),
                          child: new SizedBox(
                            width: 70.0,
                            height: 45.0,
                            child: new Center(
                                child: new Text('${food.value["quantidade"]?? 0}',
                                    style: Theme.of(context).textTheme.subhead,
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.add),
                          onPressed: increment,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
