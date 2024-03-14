import 'package:flutter/material.dart';

// A widget to animate a child widget fading in and scaling up.
//
// The widget will only animate if hasLoadedBefore is false.
// If hasLoadedBefore is true, the widget will already be visible and not animated.
//
// This is useful for fading in sections of the UI for effects or to show that
// the content has loaded.
//
// The widget can be animated by calling the fadeIn method of its currentState.
class LoadingFadeIn extends StatefulWidget {
  static const animationDuration = Duration(milliseconds: 300);

  final bool hasLoadedBefore;
  final Widget child;

  const LoadingFadeIn({
    super.key,
    required this.hasLoadedBefore,
    required this.child,
  });

  @override
  LoadingFadeInState createState() => LoadingFadeInState();
}

class LoadingFadeInState extends State<LoadingFadeIn> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.hasLoadedBefore;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isVisible ? 1 : 0.9,
      alignment: Alignment.topCenter,
      duration: LoadingFadeIn.animationDuration,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: LoadingFadeIn.animationDuration,
        child: widget.child,
      ),
    );
  }

  void fadeIn() {
    setState(() {
      _isVisible = true;
    });
  }
}
