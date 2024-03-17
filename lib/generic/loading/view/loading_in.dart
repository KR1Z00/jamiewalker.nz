import 'package:flutter/material.dart';

/// A widget to animate a child widget loading in.
abstract class LoadingIn extends StatefulWidget {
  static const animationDuration = Duration(milliseconds: 600);

  final bool shouldAnimate;
  final Widget child;

  const LoadingIn({
    super.key,
    required this.shouldAnimate,
    required this.child,
  });

  @override
  LoadingInState createState();
}

abstract class LoadingInState extends State<LoadingIn> {
  late bool _isVisible;
  bool get isVisible => _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = !widget.shouldAnimate;
  }

  void startAnimation() {
    setState(() {
      _isVisible = true;
    });
  }
}
