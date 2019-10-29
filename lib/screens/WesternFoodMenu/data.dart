import 'package:food_ordering_app/components/menuCardData.dart';

class DataListBuilder {
  List<menuCardData> westernBreakfastCards = <menuCardData>[];
  List<menuCardData> westernLunchCards = <menuCardData>[];
  List<menuCardData> westernDessertsCards = <menuCardData>[];

  menuCardData breakfastCard1 = new menuCardData(
      image: 'assets/western-food/breakfast/egg-benedict.jpg',
      dishName: 'Egg Benedict',
      amount: '60',
      veg: false,
      quantity: 0);
  menuCardData breakfastCard2 = new menuCardData(
      image: 'assets/western-food/breakfast/chicken-fajita.jpg',
      dishName: 'Chicken Fatija',
      amount: '90',
      veg: false,
      quantity: 1);
  menuCardData breakfastCard3 = new menuCardData(
      image: 'assets/western-food/breakfast/french-toast.jpg',
      dishName: 'French Toast',
      amount: '40',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard4 = new menuCardData(
      image: 'assets/western-food/breakfast/buttermilk-pancake.jpg',
      dishName: 'Buttermilk Pancake',
      amount: '70',
      veg: true,
      quantity: 2);
  menuCardData breakfastCard5 = new menuCardData(
      image: 'assets/western-food/breakfast/monte-cristo.jpg',
      dishName: 'Monte Cristo',
      amount: '80',
      veg: true,
      quantity: 0);

  //Lunch

  menuCardData lunchCard1 = new menuCardData(
      image: 'assets/western-food/lunch/grilled-buffalo-chicken-tacos.jpg',
      dishName: 'Grilled Buffalo Chicken Tacos',
      amount: '170',
      veg: false,
      quantity: 1);
  menuCardData lunchCard2 = new menuCardData(
      image: 'assets/western-food/lunch/chicken-fingers.jpg',
      dishName: 'Chicken Fingers',
      amount: '120',
      veg: false,
      quantity: 0);
  menuCardData lunchCard3 = new menuCardData(
      image: 'assets/western-food/lunch/spanakopita.jpg',
      dishName: 'Spanakopitay',
      amount: '160',
      veg: false,
      quantity: 1);
  menuCardData lunchCard4 = new menuCardData(
      image: 'assets/western-food/lunch/veggie-burger.jpg',
      dishName: 'Veggie Burger',
      amount: '140',
      veg: true,
      quantity: 1);
  menuCardData lunchCard5 = new menuCardData(
      image: 'assets/western-food/lunch/greek-salad.jpg',
      dishName: 'Greek Salad',
      amount: '90',
      veg: true,
      quantity: 1);

  //Desserts

  menuCardData dessertCard1 = new menuCardData(
      image: 'assets/western-food/desserts/raspberry-tiramisu.jpg',
      dishName: 'Raspberry Tiramisu',
      amount: '60',
      veg: true,
      quantity: 1);
  menuCardData dessertCard2 = new menuCardData(
      image: 'assets/western-food/desserts/waffle-sundae.jpg',
      dishName: 'Waffle Sundae',
      amount: '120',
      veg: true,
      quantity: 0);
  menuCardData dessertCard3 = new menuCardData(
      image: 'assets/western-food/desserts/baklava.jpg',
      dishName: 'Baklava',
      amount: '80',
      veg: true,
      quantity: 0);

  DataListBuilder() {
    westernBreakfastCards.add(breakfastCard1);
    westernBreakfastCards.add(breakfastCard2);
    westernBreakfastCards.add(breakfastCard3);
    westernBreakfastCards.add(breakfastCard4);
    westernBreakfastCards.add(breakfastCard5);

    westernLunchCards.add(lunchCard1);
    westernLunchCards.add(lunchCard2);
    westernLunchCards.add(lunchCard3);
    westernLunchCards.add(lunchCard4);
    westernLunchCards.add(lunchCard5);

    westernDessertsCards.add(dessertCard1);
    westernDessertsCards.add(dessertCard2);
    westernDessertsCards.add(dessertCard3);
  }
}
