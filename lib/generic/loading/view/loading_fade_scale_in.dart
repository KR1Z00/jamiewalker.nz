import 'package:flutter/material.dart';
import 'package:jamie_walker_website/generic/loading/view/loading_in.dart';

// A widget to animate a child widget fading and scaling in.
class LoadingFadeScaleIn extends LoadingIn {
  const LoadingFadeScaleIn({
    super.key,
    required super.shouldAnimate,
    required super.child,
  });

  @override
  LoadingFadeScaleInState createState() => LoadingFadeScaleInState();
}

class LoadingFadeScaleInState extends LoadingInState {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isVisible ? 1 : 0.9,
      alignment: Alignment.topCenter,
      duration: LoadingIn.animationDuration,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: LoadingIn.animationDuration,
        child: widget.child,
      ),
    );
  }
}
