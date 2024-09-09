import 'package:flutter/material.dart';
import 'package:starbucks_app/drink_screen.dart';

class Drinkcard  extends StatelessWidget{
  DrinkScreen drink;
  Drinkcard(this.drink);
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    double cardWidth= size.width-60;
    double cardHeight= size.height*.55;

    return Container(
      child: Stack(
        clipBehavior: Clip.none, children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth, cardHeight,size),
        ],
      ),
    );
  }
  
  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text(
            drink.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.lightColor),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.dartColor),
          ),
        ],
      ),
    );
  }
  
  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            drink.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}