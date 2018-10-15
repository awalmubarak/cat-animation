import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;
  bool isTop = true;

  @override
  void initState() {
    super.initState();
    boxController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );

    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();

    catController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else {
      catController.forward();
      boxController.stop();
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
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
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
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.00,
          left: 0.00,
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

  Widget buildLeftFlap() {
    return Positioned(
      top: 4.0,
      left: 9.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
        child: Container(
          color: Colors.brown,
          height: 10.0,
          width: 125.0,
        ),
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      top: 4.0,
      right: 9.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
        child: Container(
          color: Colors.brown,
          height: 10.0,
          width: 125.0,
        ),
      ),
    );
  }
}
