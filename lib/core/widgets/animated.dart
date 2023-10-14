import 'package:flutter/material.dart';

Widget animatedInAndOut({
  required bool isDisplayed,
  required Widget component,
  double left = 0,
  double right = 0,
}) {
  return AnimatedPadding(
    curve: Curves.decelerate,
    duration: const Duration(milliseconds: 250),
    padding: EdgeInsets.only(
      bottom: isDisplayed ? 0 : 80,
      left: left,
      right: right,
    ),
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: isDisplayed ? 1 : 0,
      child: component,
    ),
  );
}
