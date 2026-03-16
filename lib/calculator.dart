import 'dart:io';
import 'package:flutter/cupertino.dart';



class Calculator extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


void main() {
  print('--- Simple Calculator ---');

  stdout.write('Enter first number: ');
  double num1 = double.parse(stdin.readLineSync()!);

  stdout.write('Enter second number: ');
  double num2 = double.parse(stdin.readLineSync()!);

  print('Choose operation:');
  print('1. Addition (+)');
  print('2. Subtraction (-)');
  print('3. Multiplication (*)');
  print('4. Division (/)');

  stdout.write('Enter your choice (1-4): ');
  int choice = int.parse(stdin.readLineSync()!);

  double result;

  switch (choice) {
    case 1:
      result = num1 + num2;
      print('Result: $num1 + $num2 = $result');
      break;

    case 2:
      result = num1 - num2;
      print('Result: $num1 - $num2 = $result');
      break;

    case 3:
      result = num1 * num2;
      print('Result: $num1 * $num2 = $result');
      break;

    case 4:
      if (num2 != 0) {
        result = num1 / num2;
        print('Result: $num1 / $num2 = $result');
      } else {
        print('Error: Division by zero is not allowed.');
      }
      break;

    default:
      print('Invalid choice');
  }
}