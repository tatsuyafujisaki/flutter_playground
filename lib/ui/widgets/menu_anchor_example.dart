import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
  ProviderScope(
    child: MaterialApp(
      home: Scaffold(appBar: AppBar(leading: _MyStatefulWidget())),
    ),
  ),
);

class _MyStatefulWidget extends StatefulWidget {
  @override
  State<_MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) => MenuAnchor(
    onOpen: () => setState(() => isMenuOpen = true),
    onClose: () => setState(() => isMenuOpen = false),
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () async => _showDialog('🍎'),
        child: const Text('🍎'),
      ),
      MenuItemButton(
        onPressed: () async => _showDialog('🍊'),
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
