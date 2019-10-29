 class HomeCardData {
  String thumbnail;
  String name;
  String timing;
  String quisine;
  String price;
  String offer1;
  String offer2;

  HomeCardData(
      {this.name,
      this.offer1,
      this.offer2,
      this.price,
      this.quisine,
      this.thumbnail,
      this.timing});
}

class DataListBuilder {
  List<HomeCardData> cardList = new List<HomeCardData>();

  HomeCardData card1 = new HomeCardData(
      thumbnail: "assets/home-page/rajdhani.jpg",
      name: "Arroz Branco",
      timing: "100g",
      quisine: "2 Cal.",
      price: "Rs. 1,00",
      offer1: "20% desc. janta",
      offer2: "...");

  HomeCardData card2 = new HomeCardData(
      thumbnail: "assets/home-page/kamat-swaad.jpg",
      name: "Feijão",
      timing: "120g",
      quisine: "5 Cal.",
      price: "Rs. 2,00",
      offer1: "15% desc. janta",
      offer2: "contém ferro");
  HomeCardData card3 = new HomeCardData(
      thumbnail: "assets/home-page/chhattisgarhi-thali.jpg",
      name: "Bife",
      timing: "150g",
      quisine: "3 Cal.",
      price: "Rs. 2,00",
      offer1: "10% desc. janta",
      offer2: "proteína");
  HomeCardData card4 = new HomeCardData(
      thumbnail: "assets/home-page/kathiawadi-thali.jpg",
      name: "Maionese",
      timing: "100g",
      quisine: "5 Cal.",
      price: "Rs. 1,00",
      offer1: "12% desc. janta",
      offer2: "...");
  HomeCardData card5 = new HomeCardData(
      thumbnail: "assets/home-page/annapoorni.jpg",
      name: "Salada",
      timing: "0.50g",
      quisine: "1 Cal.",
      price: "Rs 0,50",
      offer1: "16% desc. janta",
      offer2: "vitamina");
  DataListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList.add(card4);
    cardList.add(card5);
  }
}
