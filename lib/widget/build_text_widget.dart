import 'package:flutter/material.dart';

class BuildTextWidget extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const BuildTextWidget({
    super.key,
    this.text,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.textDecoration,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
