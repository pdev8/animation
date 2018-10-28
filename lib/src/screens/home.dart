import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  // Lifecycle method is only avaible for classes that extend the
  // state base class
  initState() {
    super.initState();

    // This controller controls the animation; it has the ability
    // to start, stop, or restart the animation
    catController = AnimationController(
      // Animation of cat going up/down to last 2 seconds
      duration: Duration(
        seconds: 2
      ),
      // @required TickerProvider vsync
      // The ticker provider is like a handle from the outside that
      // has the ability to reach in and tell the animation to progress
      // along and render the next frame of the animation
      vsync: this
    );

    // Tween describes the range that the value being animated spans
    // Will change the elevation of the cat from 0 to 100
    catAnimation = Tween(begin: 0.0, end: 100.0)
      .animate(
        // The rate in which the animated value will change
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        )
      );
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Text('Animation!')), body: buildAnimation());
  }

  Widget buildAnimation() {
    return Cat();
  }
}