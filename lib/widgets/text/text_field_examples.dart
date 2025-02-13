import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: _createBody())));

Widget _createBody() => Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _createRectangleTextField(),
    _createRectangleTextField(InputBorder.none),
    _createRoundedTextField(BorderSide.none),
    // The border width is 0,
    // but the border style is NOT "BorderStyle.none".
    _createRoundedTextField(const BorderSide(width: 0)),
    // The border style is "BorderStyle.none",
    // but the border width is NOT 0.
    _createRoundedTextField(
      const BorderSide(width: 100, style: BorderStyle.none),
    ),
  ],
);

TextField _createRectangleTextField([InputBorder? border]) => TextField(
  decoration: InputDecoration(
    labelText: 'Label!',
    helperText: 'Hint!',
    filled: true,
    fillColor: Colors.yellow,
    border: border,
  ),
);

TextField _createRoundedTextField(BorderSide borderSide) => TextField(
  decoration: InputDecoration(
    labelText: 'Label!',
    helperText: 'Hint!',
    filled: true,
    fillColor: Colors.yellow,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: borderSide,
    ),
  ),
);
