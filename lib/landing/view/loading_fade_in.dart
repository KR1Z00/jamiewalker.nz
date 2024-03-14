import 'package:flutter/material.dart';

class LoadingFadeIn extends StatefulWidget {
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
    const duration = Duration(milliseconds: 300);
    return AnimatedScale(
      scale: _isVisible ? 1 : 0.9,
      duration: duration,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: duration,
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
