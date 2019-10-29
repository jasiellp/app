import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/menuCard.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/data.dart';

class Desserts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataListBuilder dessertsCardDataList = new DataListBuilder();

    return new ListView(
      children: <Widget>[
        new MenuCardBuilder(
          cards: dessertsCardDataList.indianDessertsCards,
        )
      ],
    );
  }
}
