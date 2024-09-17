import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: _MyStatelessWidget(),
        ),
      ),
    );

class _MyStatelessWidget extends StatelessWidget {
  final myFuture = Future<String>.delayed(
    const Duration(seconds: 5),
    () => '🍎',
  );

  @override
  Widget build(BuildContext context) => Center(
        child: FutureBuilder<String>(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              debugPrintStack(stackTrace: snapshot.stackTrace);
              return const Icon(Icons.error);
            }
            return const CircularProgressIndicator();
          },
        ),
      );
}
