import 'package:calculadora_app/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calc_button.dart';

class CalculatorButtons extends StatelessWidget {
  final calculatorCtrl = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            _buildFunctionButtons(),
            _buildBaseButtons(),
            ..._buildNumberButtons(),
            _buildHexButtons(),
            _buildOperatorButtons(),
          ],
        ));
  }

  Widget _buildFunctionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          text: 'AC',
          bgColor: Colors.redAccent,
          onPressed: () => calculatorCtrl.resetAll(),
        ),
        CalculatorButton(
          text: '+/-',
          bgColor: Colors.blueAccent,
          onPressed: () => calculatorCtrl.changeNegativePositive(),
        ),
        CalculatorButton(
          text: 'del',
          bgColor: Colors.orangeAccent,
          onPressed: () => calculatorCtrl.deleteLastEntry(),
        ),
      ],
    );
  }

  Widget _buildBaseButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBaseButton('Bin', 2),
        _buildBaseButton('Oct', 8),
        _buildBaseButton('Dec', 10),
        _buildBaseButton('Hex', 16),
      ],
    );
  }

  Widget _buildBaseButton(String text, int base) {
    return CalculatorButton(
      text: text,
      bgColor: Colors.deepPurpleAccent,
      onPressed: () => calculatorCtrl.changeBase(base),
    );
  }

  List<Widget> _buildNumberButtons() {
    final base = calculatorCtrl.base.value;
    final List<Widget> numberButtons = [];

    if (base >= 2) {
      numberButtons.add(_buildNumberRow(['0', '1']));
    }
    if (base > 2) {
      numberButtons.add(_buildNumberRow(['2', '3']));
    }
    if (base > 4) {
      numberButtons.add(
          _buildNumberRow(['4', '5', if (base > 6) '6', if (base > 7) '7']));
    }
    if (base > 8) {
      numberButtons.add(_buildNumberRow(['8', '9']));
    }

    // Botón para el punto decimal en base 10
    if (base == 10) {
      numberButtons.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CalculatorButton(
            //   text: '0',
            //   big: true,
            //   bgColor: Colors.grey,
            //   onPressed: () => calculatorCtrl.addNumber('0'),
            // ),
            // CalculatorButton(
            //   text: '.',
            //   bgColor: Colors.grey,
            //   onPressed: () => calculatorCtrl.addDecimalPoint(),
            // ),
          ],
        ),
      );
    }

    return numberButtons;
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers
          .map((number) => CalculatorButton(
                text: number,
                bgColor: Colors.grey,
                onPressed: () => calculatorCtrl.addNumber(number),
              ))
          .toList(),
    );
  }

  Widget _buildOperatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          text: '+',
          bgColor: Colors.pinkAccent,
          onPressed: () => calculatorCtrl.selectOperation('+'),
        ),
        CalculatorButton(
          text: '-',
          bgColor: Colors.pinkAccent,
          onPressed: () => calculatorCtrl.selectOperation('-'),
        ),
        CalculatorButton(
          text: 'X',
          bgColor: Colors.pinkAccent,
          onPressed: () => calculatorCtrl.selectOperation('X'),
        ),
        CalculatorButton(
          text: '/',
          bgColor: Colors.pinkAccent,
          onPressed: () => calculatorCtrl.selectOperation('/'),
        ),
        CalculatorButton(
          text: '=',
          bgColor: Colors.greenAccent,
          onPressed: () => calculatorCtrl.calculateResult(),
        ),
      ],
    );
  }

  Widget _buildHexButtons() {
    if (calculatorCtrl.base.value != 16) return SizedBox.shrink();

    return Column(
      children: [
        _buildNumberRow(['A', 'B', 'C']),
        _buildNumberRow(['D', 'E', 'F']),
      ],
    );
  }
}
