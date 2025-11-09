String _convertToCodeUnitInHex(String character) =>
    '0x${character.codeUnitAt(0).toRadixString(16).toUpperCase()}';

void main() async {
  const space = ' ';
  print(_convertToCodeUnitInHex(space)); // 0x20

  const ideographicSpace = '　';
  print(_convertToCodeUnitInHex(ideographicSpace)); // 0x3000

  const lineFeed = '\n';
  print(_convertToCodeUnitInHex(lineFeed)); // 0xA
}
