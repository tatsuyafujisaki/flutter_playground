import 'package:flutter/material.dart';

Widget ovalOutlinedButtonExample() => OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.yellow,
        side: const BorderSide(color: Colors.red),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: const Text('Click me!'),
    );
