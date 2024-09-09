import 'package:flutter/material.dart';
import 'package:starbucks_app/colors.dart';
import 'package:starbucks_app/drinkCard.dart';
import 'package:starbucks_app/drink_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[buildTooBar(),
        buldLogo(size),
        buildPager(size),
        ],
      )),
    );
  }

  Widget buildTooBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Image.asset(
            "images/location.png",
            width: 30,
            height: 30,
          ),
          Spacer(),
          Image.asset(
            "images/drawer.png",
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
  
  Widget buldLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width/2-25,
      child: Image.asset("images/logo.png", width: 50, height: 50,),
    );
  }
  
 Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height-50,
      child: PageView.builder(itemCount: getDrinks().length, itemBuilder: (context,index)=>Drinkcard(getDrinks()[index])),
    );
  }
  List<DrinkScreen> getDrinks() {
    List<DrinkScreen> list = [];
    list.add(DrinkScreen(
        'Tirami',
        'Sù',
        'images/blur_image.png',
        'images/bean_top.png',
        'images/bean_small.png',
        'images/bean_blur.png',
        'images/cup.png',
        'then top with whipped cream and mocha drizzle to bring you endless \njava joy',
        mBrownLight,
        mBrown));
    list.add(DrinkScreen(
        'Green',
        'Tea',
        'images/green_image.png',
        'images/green_top.png',
        'images/green_small.png',
        'images/green_blur.png',
        'images/green_tea_cup.png',
        'milk and ice and top it with sweetened whipped cream to give you \na delicious boost\nof energy.',
        greenLight,
        greenDark));
    list.add(DrinkScreen(
        'Triple',
        'Mocha',
        'images/mocha_image.png',
        'images/chocolate_top.png',
        'images/chocolate_small.png',
        'images/chocolate_blur.png',
        'images/mocha_cup.png',
        'layers of whipped cream that’s infused with cold brew, white chocolate mocha and dark \ncaramel.',
        mBrownLight,
        mBrown));
    return list;
  }
}
