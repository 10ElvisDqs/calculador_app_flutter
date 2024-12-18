import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final Color bgColor;
  final bool big;
  final String text;
  final Function onPressed;

  CalculatorButton({
    Key? key,
    required this.bgColor,
    this.big = false,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: Color.fromARGB(255, 0, 0, 0),
      shape: StadiumBorder(),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 1, left: 1),
      child: TextButton(
        style: buttonStyle,
        onPressed: () => onPressed(),
        child: Container(
          width: big ? 100 : 50, // Ajusta el ancho del botón grande y pequeño
          height: 30, // Ajusta la altura del botón
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300), // Ajusta el tamaño del texto
            ),
          ),
        ),
      ),
    );
  }
}
