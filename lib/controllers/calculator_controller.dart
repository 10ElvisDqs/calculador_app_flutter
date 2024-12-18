import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var firstNumber = '10'.obs;
  var secondNumber = '20'.obs;
  var mathResult = '30'.obs;
  var operation = '+'.obs;
  var base = 10.obs; // Base decimal por defecto

  void resetAll() {
    firstNumber.value = '0';
    secondNumber.value = '0';
    mathResult.value = '0';
    operation.value = '+';
  }

  void changeBase(int newBase) {
    String currentResult = mathResult.value;

    mathResult.value = int.parse(currentResult, radix: base.value)
        .toRadixString(newBase)
        .toUpperCase();
    firstNumber.value = int.parse(firstNumber.value, radix: base.value)
        .toRadixString(newBase)
        .toUpperCase();
    secondNumber.value = int.parse(secondNumber.value, radix: base.value)
        .toRadixString(newBase)
        .toUpperCase();
    base.value = newBase;
  }

  void changeNegativePositive() {
    if (mathResult.value.startsWith('-')) {
      mathResult.value = mathResult.value.replaceFirst('-', '');
    } else {
      mathResult.value = '-' + mathResult.value;
    }
  }

  void addNumber(String number) {
    if (!_isValidDigit(number, base.value)) return;

    if (mathResult.value == '0') {
      mathResult.value = number;
      return;
    }

    if (mathResult.value == '-0') {
      mathResult.value = '-' + number;
      return;
    }

    mathResult.value = mathResult.value + number;
  }

  // void addDecimalPoint() {
  //   if (base.value != 10) return; // No permitir punto decimal si no es base 10

  //   if (mathResult.value.contains('.')) return;

  //   mathResult.value = mathResult.value + '.';
  // }

  void selectOperation(String newOperation) {
    operation.value = newOperation;
    firstNumber.value = mathResult.value;
    mathResult.value = '0';
  }

  void deleteLastEntry() {
    if (mathResult.value.replaceAll('-', '').length > 1) {
      mathResult.value =
          mathResult.value.substring(0, mathResult.value.length - 1);
    } else {
      mathResult.value = '0';
    }
  }

  void calculateResult() {
    int num1 = int.parse(firstNumber.value, radix: base.value);
    int num2 = int.parse(mathResult.value, radix: base.value);
    int result;

    secondNumber.value = mathResult.value;

    switch (operation.value) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '/':
        if (num2 == 0) {
          // Manejo de división por cero
          mathResult.value = 'Error';
          return;
        }
        result = num1 ~/ num2;
        break;
      case 'X':
        result = num1 * num2;
        break;
      default:
        return;
    }

    mathResult.value = result.toRadixString(base.value).toUpperCase();
  }

  bool _isValidDigit(String digit, int base) {
    switch (base) {
      case 2:
        return RegExp(r'^[01]$').hasMatch(digit);
      case 8:
        return RegExp(r'^[0-7]$').hasMatch(digit);
      case 10:
        return RegExp(r'^[0-9]$').hasMatch(digit);
      case 16:
        return RegExp(r'^[0-9a-fA-F]$').hasMatch(digit);
      default:
        return false;
    }
  }
}
