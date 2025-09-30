import 'package:flutter/material.dart';

enum SlideDirection { left, right, top, bottom }

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final SlideDirection direction;
  final double offset;

  const SlideInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.direction = SlideDirection.bottom,
    this.offset = 50.0,
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    final begin = _getBeginOffset();
    _animation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Offset _getBeginOffset() {
    final normalizedOffset = widget.offset / 100;
    return switch (widget.direction) {
      SlideDirection.left => Offset(-normalizedOffset, 0),
      SlideDirection.right => Offset(normalizedOffset, 0),
      SlideDirection.top => Offset(0, -normalizedOffset),
      SlideDirection.bottom => Offset(0, normalizedOffset),
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}
