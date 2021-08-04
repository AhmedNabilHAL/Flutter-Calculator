

import 'package:calculator/components/calculator_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);


  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  double result = 0.0;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CalculatorForm(callback: calculateResult),
        const Text("Result:"),
        Text(result.toString()),
      ],
    );
  }

  void calculateResult(String result) {
    print("callback function called with " + result);
    setState(() {
      this.result = double.parse(result);
    });
  }
}