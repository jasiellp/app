import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/menuCard.dart';
import 'package:food_ordering_app/screens/WesternFoodMenu/data.dart';

class Lunch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataListBuilder lunchCardDataList = new DataListBuilder();

    return new ListView(
      children: <Widget>[
        new MenuCardBuilder(
          cards: lunchCardDataList.westernLunchCards,
        )
      ],
    );
  }
}
