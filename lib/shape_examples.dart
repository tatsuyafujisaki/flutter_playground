import 'package:flutter/material.dart';

void ovalOutlinedButtonExample() {
  OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    ),
    child: const Text('Click me!'),
  );
}
