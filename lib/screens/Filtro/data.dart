class Quisines {
  String quisine;
  bool quisineChecked;
  Quisines({this.quisineChecked, this.quisine});
}

class DataListBuilder {
  List<Quisines> quisinesList = <Quisines>[];
  Quisines quisineCard1 =
      new Quisines(quisine: 'Sweets', quisineChecked: false);
  Quisines quisineCard2 =
      new Quisines(quisine: 'Arabian', quisineChecked: false);
  Quisines quisineCard3 =
      new Quisines(quisine: 'Bakery', quisineChecked: false);
  Quisines quisineCard4 =
      new Quisines(quisine: 'Bengali', quisineChecked: false);
  Quisines quisineCard5 =
      new Quisines(quisine: 'Biryani', quisineChecked: false);
  Quisines quisineCard6 =
      new Quisines(quisine: 'Beverages', quisineChecked: false);
  Quisines quisineCard7 = new Quisines(quisine: 'Cafe', quisineChecked: false);

  Quisines quisineCard8 =
      new Quisines(quisine: 'Chinese', quisineChecked: true);
  Quisines quisineCard9 =
      new Quisines(quisine: 'Continental', quisineChecked: true);
  Quisines quisineCard10 =
      new Quisines(quisine: 'Desserts', quisineChecked: false);
  Quisines quisineCard11 =
      new Quisines(quisine: 'Fast Food', quisineChecked: false);
  Quisines quisineCard12 =
      new Quisines(quisine: 'Gujarati', quisineChecked: false);
  Quisines quisineCard13 =
      new Quisines(quisine: 'Hyderabadi', quisineChecked: false);
  Quisines quisineCard14 =
      new Quisines(quisine: 'Indian', quisineChecked: false);
  Quisines quisineCard15 =
      new Quisines(quisine: 'Japanese', quisineChecked: false);
  Quisines quisineCard16 =
      new Quisines(quisine: 'Sea Food', quisineChecked: false);
  Quisines quisineCard17 = new Quisines(quisine: 'Thai', quisineChecked: false);

  DataListBuilder() {
    quisinesList.add(quisineCard1);
    quisinesList.add(quisineCard2);
    quisinesList.add(quisineCard3);
    quisinesList.add(quisineCard4);
    quisinesList.add(quisineCard5);
    quisinesList.add(quisineCard6);
    quisinesList.add(quisineCard7);
    quisinesList.add(quisineCard8);
    quisinesList.add(quisineCard9);
    quisinesList.add(quisineCard10);
    quisinesList.add(quisineCard11);
    quisinesList.add(quisineCard12);
    quisinesList.add(quisineCard13);
    quisinesList.add(quisineCard14);
    quisinesList.add(quisineCard15);
    quisinesList.add(quisineCard16);
    quisinesList.add(quisineCard17);
  }
}
