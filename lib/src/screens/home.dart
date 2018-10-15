import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  bool isTop = true;

  @override
  void initState() {
    super.initState();
    catController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    catAnimation = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else {
      catController.forward();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anim Bird"),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            children: <Widget>[
              buildCatAnimation(),
              buildBox()
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value),
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      color: Colors.brown,
      height: 200.0,
      width: 200.0,
    );
  }
}
