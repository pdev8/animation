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
        // Animation of cat going up/down to last x seconds
        duration: Duration(milliseconds: 200),
        // @required TickerProvider vsync
        // The ticker provider is like a handle from the outside that
        // has the ability to reach in and tell the animation to progress
        // along and render the next frame of the animation
        vsync: this);

    // Tween describes the range that the value being animated spans
    // Will change the elevation of the cat from 0 to 100
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
        // The rate in which the animated value will change
        CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  // Animation will begin on tap
  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      // Starts the animation
      catController.forward();
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Text('Animation!')),
        // Anytime a user taps on anything that is a child of this gesture
        // animation/detector, the tap event will bubble up until it reaches
        // the GestureDetector (IMPORTANT because - the tap event on the box will bubble up)
        body: GestureDetector(
            child: Center(
                // Whatever is last in the array, shows on top
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[buildCatAnimation(), buildBox()],
            )),
            onTap: onTap));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        // In a StreamBuilder, a widget was returned, but it doesn't make sense
        // to use it in this scenario because we will be changing the value frequently
        builder: (context, child) {
          // The only way we can rerender the screen is by creating a new widget
          // Recreating a Container is better than recreating the more expensive Cat
          // widget
          return Positioned(
              child: child,
              // If we used 'bottom', the box would move downwards
              top: catAnimation.value,
              right: 0.0,
              left: 0.0);
        },
        // Declares the child widget only once and will better in terms of performance
        child: Cat());
  }

  Widget buildBox() {
    return Container(height: 200.0, width: 200.0, color: Colors.brown);
  }
}
