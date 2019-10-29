import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/Filtro/data.dart';

class QuisineBuilder extends StatefulWidget {
  final List<Quisines> itemList;

  const QuisineBuilder({this.itemList});

  @override
  _QuisineBuilderState createState() =>
      new _QuisineBuilderState(itemList: itemList);
}

class _QuisineBuilderState extends State<QuisineBuilder> {
  List<Quisines> itemList;

  _QuisineBuilderState({this.itemList});

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: itemList.map((Quisines quisineCard) {
      return new Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(
              color: Colors.black26,
            ))),
        child: new ListTile(
          title: new Text(
            quisineCard.quisine,
            style: new TextStyle(
              color: const Color.fromRGBO(153, 153, 153, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: new Checkbox(
            value: quisineCard.quisineChecked,
            activeColor: const Color.fromRGBO(153, 153, 153, 1.0),
            onChanged: (bool val) {
              setState(() {
                quisineCard.quisineChecked = val;
              });
            },
          ),
        ),
      );
    }).toList());
  }
}
