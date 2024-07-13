import 'package:calculator_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;

  var input = "";
  var output = "";
  var operation = '';
  var hideInput = false;
  var outputSize = 30.0;

  onButtonClick(value) {
    print(value);
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isEmpty) {
        return;
      }
      input = input.substring(0, input.length - 1);
    } else if (value == '=') {
      if (input.isEmpty) {
        return;
      }
      var userInput = input;
      userInput = input.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputSize = 50.0;
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 30.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 85, 85, 85),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? " " : input,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )),
            Row(
              children: [
                button(
                    text: 'AC',
                    tColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(
                    text: '<',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                button(
                    text: '+/-',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                button(
                    text: '/',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(
                    text: 'x',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(
                    text: '-',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(
                    text: '+',
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: '0'),
                button(
                    text: '.',
                    tColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(
                    text: '%',
                    tColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(text: '=', buttonBgColor: orangeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            color: tColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          onButtonClick(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBgColor,
          padding: EdgeInsets.all(18),
        ),
      ),
    ));
  }
}
