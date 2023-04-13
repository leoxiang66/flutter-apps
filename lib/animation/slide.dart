import 'package:flutter/material.dart';

class SmoothSlide extends StatefulWidget {
  final Widget child;
  final Offset start;
  final Offset end;
  final Duration duration;

  const SmoothSlide({super.key, 
    required this.child,
    required this.start,
    required this.end,
    required this.duration,
  });

  @override
  _SmoothSlideState createState() => _SmoothSlideState();
}

class _SmoothSlideState extends State<SmoothSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.start,
      end: widget.end,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}



class EaseOutSlide extends StatefulWidget {
  final Widget child;
  final Offset start;
  final Offset end;
  final Duration duration;

  const EaseOutSlide({super.key, 
    required this.child,
    required this.start,
    required this.end,
    required this.duration,
  });

  @override
  _EaseOutSlideState createState() => _EaseOutSlideState();
}

class _EaseOutSlideState extends State<EaseOutSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.start,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
