import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/menuCard.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/data.dart';

class Starter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataListBuilder starterCardDataList = new DataListBuilder();

    return new ListView(
      children: <Widget>[
        new MenuCardBuilder(
          cards: starterCardDataList.indianStarterCards,
        )
      ],
    );
  }
}
