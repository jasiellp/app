import 'package:food_ordering_app/components/menuCardData.dart';

class DataListBuilder {
  List<menuCardData> indianBreakfastCards = <menuCardData>[];
  List<menuCardData> indianMainCourseCards = <menuCardData>[];
  List<menuCardData> indianDessertsCards = <menuCardData>[];
  List<menuCardData> indianStarterCards = <menuCardData>[];

  menuCardData breakfastCard1 = new menuCardData(
      image: 'assets/indian-food/breakfast/dosa.jpg',
      dishName: 'Masala Dosa',
      amount: '60',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard2 = new menuCardData(
      image: 'assets/indian-food/breakfast/idli-vada.jpg',
      dishName: 'Coca-Cola',
      amount: '40',
      veg: true,
      quantity: 1);
  menuCardData breakfastCard3 = new menuCardData(
      image: 'assets/indian-food/breakfast/aloo-paratha.jpg',
      dishName: 'Doce de Leite',
      amount: '50',
      veg: true,
      quantity: 2);
  menuCardData breakfastCard4 = new menuCardData(
      image: 'assets/indian-food/breakfast/cheese-mushroom-omelette.jpg',
      dishName: 'Pudim',
      amount: '60',
      veg: false,
      quantity: 1);
  menuCardData breakfastCard5 = new menuCardData(
      image: 'assets/indian-food/breakfast/rava-idli.jpg',
      dishName: 'H2O',
      amount: '30',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard6 = new menuCardData(
      image: 'assets/indian-food/breakfast/palak-paratha.jpg',
      dishName: 'Palak Paratha',
      amount: '55',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard7 = new menuCardData(
      image: 'assets/indian-food/breakfast/kurma-puri.jpg',
      dishName: 'Kurma Puri',
      amount: '50',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard8 = new menuCardData(
      image: 'assets/indian-food/breakfast/poha.jpg',
      dishName: 'Poha',
      amount: '30',
      veg: true,
      quantity: 0);
  menuCardData breakfastCard9 = new menuCardData(
      image: 'assets/indian-food/breakfast/upma.jpg',
      dishName: 'Upma',
      amount: '30',
      veg: true,
      quantity: 0);

  //Starters

  menuCardData starterCard1 = new menuCardData(
      image: 'assets/indian-food/starter/paneer-tikka.jpg',
      dishName: 'Paneer Tikka',
      amount: '120',
      veg: true,
      quantity: 1);

  menuCardData starterCard2 = new menuCardData(
      image: 'assets/indian-food/starter/hara-bhara-kabab.jpg',
      dishName: 'Hara Bhara Kabab',
      amount: '90',
      veg: true,
      quantity: 1);
  menuCardData starterCard3 = new menuCardData(
      image: 'assets/indian-food/starter/chicken-lollipop.jpg',
      dishName: 'Chicken Lollipop',
      amount: '190',
      veg: true,
      quantity: 1);
  menuCardData starterCard4 = new menuCardData(
      image: 'assets/indian-food/starter/aloo-lollipop.jpg',
      dishName: 'Aloo Lollipop',
      amount: '80',
      veg: true,
      quantity: 1);
  menuCardData starterCard5 = new menuCardData(
      image: 'assets/indian-food/starter/chicken-tikka.jpg',
      dishName: 'Chicken Tikka',
      amount: '140',
      veg: false,
      quantity: 0);
  menuCardData starterCard6 = new menuCardData(
      image: 'assets/indian-food/starter/pineapple-grill.jpg',
      dishName: 'Pineapple Grill',
      amount: '70',
      veg: true,
      quantity: 1);
  menuCardData starterCard7 = new menuCardData(
      image: 'assets/indian-food/starter/gobi-manchuri.jpg',
      dishName: 'Gobi Manchurian',
      amount: '80',
      veg: true,
      quantity: 1);
  menuCardData starterCard8 = new menuCardData(
      image: 'assets/indian-food/starter/chicken-grill.jpg',
      dishName: 'Chicken Grill',
      amount: '160',
      veg: false,
      quantity: 0);

  //Main Course

  menuCardData mainCourseCard1 = new menuCardData(
      image: 'assets/indian-food/mainCourse/kadai-paneer.jpg',
      dishName: 'Kadai Paneer',
      amount: '170',
      veg: true,
      quantity: 1);
  menuCardData mainCourseCard2 = new menuCardData(
      image: 'assets/indian-food/mainCourse/chicken-biryani.jpg',
      dishName: 'Chicken Biryani',
      amount: '120',
      veg: false,
      quantity: 1);
  menuCardData mainCourseCard3 = new menuCardData(
      image: 'assets/indian-food/mainCourse/veg-hyderabadi-gravy.jpg',
      dishName: 'Hyderabadi Gravy',
      amount: '160',
      veg: true,
      quantity: 1);
  menuCardData mainCourseCard4 = new menuCardData(
      image: 'assets/indian-food/mainCourse/prawn-curry.jpg',
      dishName: 'Prawn Curry',
      amount: '140',
      veg: false,
      quantity: 1);
  menuCardData mainCourseCard5 = new menuCardData(
      image: 'assets/indian-food/mainCourse/butter-paneer.jpg',
      dishName: 'Butter Paneer',
      amount: '190',
      veg: true,
      quantity: 1);
  menuCardData mainCourseCard6 = new menuCardData(
      image: 'assets/indian-food/mainCourse/chicken-roasted.jpg',
      dishName: 'Chicken Roasted',
      amount: '220',
      veg: false,
      quantity: 1);
  menuCardData mainCourseCard7 = new menuCardData(
      image: 'assets/indian-food/mainCourse/chicken-curry.jpg',
      dishName: 'Chicken Curry',
      amount: '160',
      veg: false,
      quantity: 0);
  menuCardData mainCourseCard8 = new menuCardData(
      image: 'assets/indian-food/mainCourse/dal-makhani.jpg',
      dishName: 'Dal Makhani',
      amount: '120',
      veg: false,
      quantity: 1);
  menuCardData mainCourseCard9 = new menuCardData(
      image: 'assets/indian-food/mainCourse/veg-biryani.jpg',
      dishName: 'Dum Biryani',
      amount: '130',
      veg: true,
      quantity: 1);

  //Desserts

  menuCardData dessertCard1 = new menuCardData(
      image: 'assets/indian-food/desserts/rabri-rasmalai.jpg',
      dishName: 'Rabri Rasmalai',
      amount: '60',
      veg: true,
      quantity: 1);
  menuCardData dessertCard2 = new menuCardData(
      image: 'assets/indian-food/desserts/gulab-jamun.jpg',
      dishName: 'Gulab Jamun',
      amount: '20',
      veg: true,
      quantity: 0);
  menuCardData dessertCard3 = new menuCardData(
      image: 'assets/indian-food/desserts/gajar-halwa.jpg',
      dishName: 'Gajar ka Halwa',
      amount: '60',
      veg: true,
      quantity: 0);
  menuCardData dessertCard4 = new menuCardData(
      image: 'assets/indian-food/desserts/rasagulla.jpg',
      dishName: 'Rasagulla',
      amount: '30',
      veg: true,
      quantity: 0);
  menuCardData dessertCard5 = new menuCardData(
      image: 'assets/indian-food/desserts/kheer.jpg',
      dishName: 'Kheer',
      amount: '70',
      veg: true,
      quantity: 0);

  menuCardData dessertCard6 = new menuCardData(
      image: 'assets/indian-food/desserts/cham-cham.jpg',
      dishName: 'Cham Cham',
      amount: '40',
      veg: true,
      quantity: 1);
  menuCardData dessertCard7 = new menuCardData(
      image: 'assets/indian-food/desserts/rabri-jalebi.jpg',
      dishName: 'Rabri Jalebi',
      amount: '30',
      veg: true,
      quantity: 1);

  DataListBuilder() {
    indianBreakfastCards.add(breakfastCard1);
    indianBreakfastCards.add(breakfastCard2);
    indianBreakfastCards.add(breakfastCard3);
    indianBreakfastCards.add(breakfastCard4);
    indianBreakfastCards.add(breakfastCard5);
    indianBreakfastCards.add(breakfastCard6);
    indianBreakfastCards.add(breakfastCard7);
    indianBreakfastCards.add(breakfastCard8);
    indianBreakfastCards.add(breakfastCard9);

    indianStarterCards.add(starterCard1);
    indianStarterCards.add(starterCard2);
    indianStarterCards.add(starterCard3);
    indianStarterCards.add(starterCard4);
    indianStarterCards.add(starterCard5);
    indianStarterCards.add(starterCard6);
    indianStarterCards.add(starterCard7);
    indianStarterCards.add(starterCard8);

    indianMainCourseCards.add(mainCourseCard1);
    indianMainCourseCards.add(mainCourseCard2);
    indianMainCourseCards.add(mainCourseCard3);
    indianMainCourseCards.add(mainCourseCard4);
    indianMainCourseCards.add(mainCourseCard5);
    indianMainCourseCards.add(mainCourseCard6);
    indianMainCourseCards.add(mainCourseCard7);
    indianMainCourseCards.add(mainCourseCard8);
    indianMainCourseCards.add(mainCourseCard9);

    indianDessertsCards.add(dessertCard1);
    indianDessertsCards.add(dessertCard2);
    indianDessertsCards.add(dessertCard3);
    indianDessertsCards.add(dessertCard4);
    indianDessertsCards.add(dessertCard5);
    indianDessertsCards.add(dessertCard6);
    indianDessertsCards.add(dessertCard7);
  }
}
