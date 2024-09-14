import 'package:flutter/material.dart';
import 'package:starbucks_app/colors.dart';
import 'package:starbucks_app/drinkCard.dart';
import 'package:starbucks_app/drink_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  PageController? pageController;
  double pageOffset = 0;
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: 0.8, initialPage: 0);
    pageController?.addListener(() {
      setState(() {
        pageOffset = pageController?.page ?? 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolBar(),
            buildLogo(size),
            buildPager(size),
            buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildToolBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          AnimatedBuilder(
            animation: animation!,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-200 * (1 - animation!.value), 0),
                child: Image.asset(
                  "images/location.png",
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          Spacer(),
          AnimatedBuilder(
            animation: animation!,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(200 * (1 - animation!.value), 0),
                child: Image.asset(
                  "images/drawer.png",
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, snapshot) {
          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, size.height / 2 * (1 - animation!.value))
              ..scale(1 + (1 - animation!.value)),
            origin: Offset(25, 25),
            child: InkWell(
              onTap: () => controller!.isCompleted
                  ? controller!.reverse()
                  : controller!.forward(),
              child: Image.asset("images/logo2.png", width: 50, height: 50),
            ),
          );
        },
      ),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(400 * (1 - animation!.value), 0),
            child: PageView.builder(
              controller: pageController,
              itemCount: getDrinks().length,
              itemBuilder: (context, index) {
                final drink = getDrinks()[index];
                return DrinkCard(
                  drink,
                  pageOffset,
                  index,
                  onPress: () => showCharacterDialog(drink.name, drink.quote),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void showCharacterDialog(String name, String quote) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$name dice:'),
          content: Text(quote),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<DrinkScreen> getDrinks() {
    return [
      DrinkScreen(
        'Megu',
        'min',
        'images/konosuba1.jpg',
        'images/bola3.png',
        'images/bola4.png',
        'images/bola4.png',
        'images/megu.png',
        'Has llegado a comprender el camino de las explosiones, Kazuma. ¿Qué te parece?',
        mRedLight,
        mRed,
              'Has llegado a comprender el camino de las explosiones, Kazuma. ¿Qué te parece?', // Cita de Megumin

      ),
      DrinkScreen(
        'Kazu',
        'ma',
        'images/kazuma_blur.jpg',
        'images/green_top.png',
        'images/green_small.png',
        'images/green_blur.png',
        'images/kazuma.png',
        '¡Adiós vida aburrida! ¡Hola nuevo mundo!"',
        greenLight,
        greenDark,
              '¡Adiós vida aburrida! ¡Hola nuevo mundo!', // Cita de Kazuma

      ),
      DrinkScreen(
        'Aq',
        'ua',
        'images/aqua3.gif',
        'images/agua3.png',
        'images/agua3.png',
        'images/agua3.png',
        'images/aqua5.png',
        '¡Soy una diosa! ¡No me trates como a una simple mortal!.',
        mBlueLight,
        mBlue,
              '¡Soy una diosa! ¡No me trates como a una simple mortal!.', // Cita de Aqua

      ),
    ];
  }

  Widget buildPageIndicator() {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller!.value,
            child: Row(
              children: List.generate(
                  getDrinks().length, (index) => buildContainer(index)),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(int index) {
    double animate = (pageOffset - index).abs();
    double size = 10;
    Color color = Colors.grey;

    if (animate <= 1) {
      size = 10 + 10 * (1 - animate);
      color = ColorTween(begin: Colors.grey, end: mAppGreen)
          .transform(1 - animate)!;
    }

    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}
