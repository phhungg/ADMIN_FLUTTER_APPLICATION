import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String label;
  final double fS;
  final FontStyle fst;
  final FontWeight fw;
  final Color? color;
  final TextDecoration textDecoration;
  final int? maxlines;
  const TitleText({
    super.key,
    required this.label,
    this.fS = 13,
    this.fst = FontStyle.normal,
    this.color,
    this.fw = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxlines,
      style: TextStyle(
        fontSize: fS,
        fontWeight: fw,
        color: color,
        fontStyle: fst,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
