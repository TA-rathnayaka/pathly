import 'package:flutter/material.dart';

class FAProgressBar extends StatefulWidget {
  const FAProgressBar({
    super.key,
    this.currentValue = 0,
    this.maxValue = 100,
    this.size = 12,
    this.animatedDuration = const Duration(milliseconds: 300),
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.borderRadius = 12,
    this.backgroundColor = const Color(0x00FFFFFF),
    this.progressColor = const Color(0xFFFA7268),
    this.changeColorValue,
    this.changeProgressColor = const Color(0xFF5F4B8B),
    this.displayText,
  });

  final int currentValue;
  final int maxValue;
  final double size;
  final Duration animatedDuration;
  final Axis direction;
  final VerticalDirection verticalDirection;
  final double borderRadius;
  final Color backgroundColor;
  final Color progressColor;
  final int? changeColorValue;
  final Color changeProgressColor;
  final String? displayText;

  @override
  _FAProgressBarState createState() => _FAProgressBarState();
}

class _FAProgressBarState extends State<FAProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _currentBegin = 0;
  double _currentEnd = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animatedDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
        .animate(_controller);
    triggerAnimation();
  }

  @override
  void didUpdateWidget(covariant FAProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    triggerAnimation();
  }

  void triggerAnimation() {
    setState(() {
      _currentBegin = _animation.value;
      _currentEnd = widget.currentValue / widget.maxValue;
      _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
          .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedProgressBar(
      animation: _animation,
      progressBarWidget: widget,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedProgressBar extends AnimatedWidget {
  const AnimatedProgressBar({
    super.key,
    required Animation<double> animation,
    required this.progressBarWidget,
  }) : super(listenable: animation);

  final FAProgressBar progressBarWidget;

  double transformValue(double x, double begin, double end, double before) {
    double y = (end * x - (begin - before)) * (1 / before);
    return y.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    Color progressColor = progressBarWidget.progressColor;

    if (progressBarWidget.changeColorValue != null) {
      final colorTween = ColorTween(
        begin: progressBarWidget.progressColor,
        end: progressBarWidget.changeProgressColor,
      );
      progressColor = colorTween.transform(
        transformValue(animation.value, progressBarWidget.changeColorValue!.toDouble(),
            progressBarWidget.maxValue.toDouble(), 5),
      )!;
    }

    List<Widget> progressWidgets = [];
    Widget progressWidget = Container(
      decoration: BoxDecoration(
        color: progressColor,
        borderRadius: BorderRadius.circular(progressBarWidget.borderRadius),
      ),
    );
    progressWidgets.add(progressWidget);

    if (progressBarWidget.displayText != null) {
      Widget textProgress = Container(
        alignment: progressBarWidget.direction == Axis.horizontal
            ? const FractionalOffset(0.95, 0.5)
            : (progressBarWidget.verticalDirection == VerticalDirection.up
            ? const FractionalOffset(0.5, 0.05)
            : const FractionalOffset(0.5, 0.95)),
        child: Text(
          '${(animation.value * progressBarWidget.maxValue).toInt()}${progressBarWidget.displayText}',
          softWrap: false,
          style: const TextStyle(color: Colors.white, fontSize: 8),
        ),
      );
      progressWidgets.add(textProgress);
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: progressBarWidget.direction == Axis.vertical
            ? progressBarWidget.size
            : null,
        height: progressBarWidget.direction == Axis.horizontal
            ? progressBarWidget.size
            : null,
        decoration: BoxDecoration(
          color: progressBarWidget.backgroundColor,
          borderRadius: BorderRadius.circular(progressBarWidget.borderRadius),
          border: Border.all(color: progressBarWidget.progressColor, width: 0.2),
        ),
        child: Flex(
          direction: progressBarWidget.direction,
          verticalDirection: progressBarWidget.verticalDirection,
          children: <Widget>[
            Expanded(
              flex: (animation.value * 100).toInt(),
              child: Stack(children: progressWidgets),
            ),
            Expanded(
              flex: 100 - (animation.value * 100).toInt(),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
