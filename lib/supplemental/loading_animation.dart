import 'dart:math';

import 'package:Shrine/colors.dart';
import 'package:flutter/material.dart';

/// Four circles that move up and down forever.
///
/// Reactive to screen size.
class LoadingAnimation extends StatefulWidget {
  LoadingAniamtionState createState() => LoadingAniamtionState();
}

class LoadingAniamtionState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  // The main controller for all the animations
  AnimationController _controller;
  // The animations
  static Animation _circleOne;
  static Animation _circleTwo;
  static Animation _circleThree;
  static Animation _circleFour;

  @override
  void initState() {
    super.initState();
    // Sets all animations to last 1.25 seconds and never end.
    _controller = AnimationController(
      duration: Duration(seconds: 1, milliseconds: 250),
      vsync: this,
    )..repeat();

    // Each animation is delayed 0.25 seonds from the last
    // This creates a staggered effect.
    _circleOne = _LoadingTween(
      begin: Offset(0, 0),
      end: Offset(0, 1),
      delay: 0.0,
    ).animate(_controller);

    _circleTwo = _LoadingTween(
      begin: Offset(0, 0),
      end: Offset(0, 1),
      delay: 0.25,
    ).animate(_controller);

    _circleThree = _LoadingTween(
      begin: Offset(0, 0),
      end: Offset(0, 1),
      delay: 0.5,
    ).animate(_controller);

    _circleFour = _LoadingTween(
      begin: Offset(0, 0),
      end: Offset(0, 1),
      delay: 0.75,
    ).animate(_controller);
  }

  /// Creates the circles that will be animated according to the
  /// screen width.
  Widget _createCircle(double sw) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kShrinePink300,
      ),
      width: sw * 0.05,
      height: sw * 0.05,
    );
  }

  /// Builds the row of all the circles with their animations.
  Widget _buildAnimation(double sw) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SlideTransition(
          position: _circleOne,
          child: _createCircle(sw),
        ),
        SlideTransition(
          position: _circleTwo,
          child: _createCircle(sw),
        ),
        SlideTransition(
          position: _circleThree,
          child: _createCircle(sw),
        ),
        SlideTransition(
          position: _circleFour,
          child: _createCircle(sw),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Container(
        height: sw * 0.20,
        width: sw * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(child: _buildAnimation(sw)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// An interpolation between two offsets at a sinusoidal frequency.
///
/// Extends the [Tween] class and overrides [Tween.lerp]. Instead of using
/// the value t directly, the value used to lerp is sin(2 * pi * (t - delay)).
/// This is a sin function with a period of 1, so when the value of t is
/// 0.25, the animation is at [end]; at t = 1, the animation returns to [begin].
///
/// The [delay] parameter can be used instead of an [Interval]. Note that the delay changes
/// the starting position, not the starting time.
///
/// [_LoadingTween] is best used for animations that repeat continuously.
class _LoadingTween extends Tween<Offset> {
  final double delay;
  _LoadingTween({@required begin, @required end, double delay = 0})
      : delay = delay,
        super(begin: begin, end: end);

  @override
  Offset lerp(double t) {
    return super.lerp(sin(2 * pi * (t - delay)));
  }
}
