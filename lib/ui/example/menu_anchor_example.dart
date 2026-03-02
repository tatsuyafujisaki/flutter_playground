import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget preview() => _MyStatefulWidget();

class _MyStatefulWidget extends StatefulWidget {
  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  var isMenuOpen = false;

  @override
  Widget build(BuildContext context) => MenuAnchor(
    onOpen: () => setState(() => isMenuOpen = true),
    onClose: () => setState(() => isMenuOpen = false),
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () => _showDialog('🍎'),
        child: const Text('🍎'),
      ),
      MenuItemButton(
        onPressed: () => _showDialog('🍊'),
        child: const Text('🍊'),
      ),
    ],
    builder: (_, controller, child) => TextButton(
      onPressed: () {
        if (controller.isOpen) {
          controller.close();
        } else {
          controller.open();
        }
      },
      child: child ?? Icon(isMenuOpen ? Icons.menu_open : Icons.menu),
    ),
  );

  Future<void> _showDialog(String title) async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(title: Text(title)),
    );
  }
}
