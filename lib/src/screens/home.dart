import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget{

  State<Home> createState() => HomeState();

}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catController;


  @override
  void initState() {
    super.initState();
    catController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: catController ,
          curve: Curves.easeIn
      )
    );

    catController.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anim Bird"),),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child){
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value),
        );
      },
      child: Cat(),
    );
  }


}
