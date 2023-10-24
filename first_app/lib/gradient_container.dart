import 'package:first_app/styled_text.dart';
import 'package:flutter/material.dart';

var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: startAlignment,
        end: endAlignment,
        colors: const [
          Colors.black,
          Colors.deepPurple,
        ],
      )),
      child: const Center(
        child: StyledText(),
      ),
    );
  }
}
