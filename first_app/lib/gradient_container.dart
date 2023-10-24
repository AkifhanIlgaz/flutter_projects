import 'package:flutter/material.dart';

var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.colors,
  });

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: startAlignment,
        end: endAlignment,
        colors: colors,
      )),
      child: Center(
        child: Image.asset("assets/images/dice-3.png"),
      ),
    );
  }
}
