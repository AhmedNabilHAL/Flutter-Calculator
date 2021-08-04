



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorForm extends StatefulWidget {
  const CalculatorForm({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty){
                return 'Please enter your calculation.';
              }
              try {
                Parser p = Parser();
                Expression exp = p.parse(myController.text);
                ContextModel cm = ContextModel();
                exp.evaluate(EvaluationType.REAL, cm);
              }
              catch(e){
                return "Invalid expression";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                  Parser p = Parser();
                  Expression exp = p.parse(myController.text);
                  ContextModel cm = ContextModel();


                  widget.callback(exp.evaluate(EvaluationType.REAL, cm).toString());
                }
              },
              child: const Text('Calculate'),
            ),
          )
        ],
      )
    );
  }
}