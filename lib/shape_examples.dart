import 'package:flutter/material.dart';

Widget ovalOutlinedButtonExample() => OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.yellow,
    side: const BorderSide(color: Colors.red),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: const Text('Click me!'),
);
