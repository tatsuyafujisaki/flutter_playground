import 'dart:developer' as developer;

String _convertToCodeUnitInHex(String character) =>
    '0x${character.codeUnitAt(0).toRadixString(16).toUpperCase()}';

void main() {
  const space = ' ';
  developer.log(_convertToCodeUnitInHex(space)); // 0x20

  const ideographicSpace = '　';
  developer.log(_convertToCodeUnitInHex(ideographicSpace)); // 0x3000

  const lineFeed = '\n';
  developer.log(_convertToCodeUnitInHex(lineFeed)); // 0xA
}
