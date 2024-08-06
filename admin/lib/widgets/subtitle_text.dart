import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String label;
  final double fS;
  final FontStyle fst;
  final FontWeight fw;
  final Color? color;
  final TextDecoration textDecoration;
  const SubtitleText({
    super.key,
    required this.label,
    this.fS = 14,
    this.fst = FontStyle.normal,
    this.color,
    this.fw = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        label,
        style: TextStyle(
          fontSize: fS,
          fontWeight: fw,
          color: color,
          fontStyle: fst,
          decoration: textDecoration,
        ),
      ),
    );
  }
}
