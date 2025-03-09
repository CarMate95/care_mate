import 'package:flutter/material.dart';

class AnimatedSelectableText extends StatefulWidget {
  final String fullText;
  final TextStyle? textStyle;
  final Duration animationDuration;

  const AnimatedSelectableText({
    super.key,
    required this.fullText,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 25),
  });

  @override
  State<AnimatedSelectableText> createState() => _AnimatedSelectableTextState();
}

class _AnimatedSelectableTextState extends State<AnimatedSelectableText>
    with AutomaticKeepAliveClientMixin {
  String animatedText = "";
  bool _isDisposed = false; // to check if the widget is disposed

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  @override
  void dispose() {
    _isDisposed = true; // select the widget is disposed
    super.dispose();
  }

  void _animateText() async {
    for (int i = 1; i <= widget.fullText.length; i++) {
      await Future.delayed(widget.animationDuration);
      if (_isDisposed) break;
      setState(() {
        animatedText = widget.fullText.substring(0, i);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SelectableText(
      animatedText,
      // style: widget.textStyle ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
