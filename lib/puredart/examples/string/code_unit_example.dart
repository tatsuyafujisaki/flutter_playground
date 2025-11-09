import 'package:flutter/foundation.dart';

String _convertToCodeUnitInHex(String character) =>
    '0x${character.codeUnitAt(0).toRadixString(16).toUpperCase()}';

void main() async {
  const space = ' ';
  debugPrint(_convertToCodeUnitInHex(space)); // 0x20

  const ideographicSpace = '　';
  debugPrint(_convertToCodeUnitInHex(ideographicSpace)); // 0x3000

  const lineFeed = '\n';
  debugPrint(_convertToCodeUnitInHex(lineFeed)); // 0xA
}
