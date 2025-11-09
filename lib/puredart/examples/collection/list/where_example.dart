import 'package:path/path.dart' as p;

void main() {
  final filenames = [
    'foo.gif',
    'foo.GIF',
    'foo.jpeg',
    'foo.JPEG',
    'foo.jpg',
    'foo.JPG',
    'foo.png',
    'foo.PNG',
  ];

  print(_filterJpeg(filenames));
  print(_filterPng(filenames));
}

Iterable<String> _filterJpeg(Iterable<String> filenames) => filenames.where(
  (filename) => {'.jpeg', '.jpg'}.contains(p.extension(filename.toLowerCase())),
);

Iterable<String> _filterPng(Iterable<String> filenames) => filenames.where(
  (filename) => p.extension(filename.toLowerCase()) == '.png',
);
