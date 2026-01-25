// ignore_for_file: avoid_print
import 'package:xml/xml.dart';

void main() {
  const bookshelfXml = '''
<?xml version="1.0"?>
    <bookshelf>
      <book>
        <title lang="english">Growing a Business</title>
        <author>Paul Hawken</author>
        <price>12.90</price>
      </book>
      <book>
        <title lang="english">The Goal</title>
        <author>Eliyahu M. Goldratt</author>
        <price>15.10</price>
      </book>
      <book>
        <title lang="french">La Peste</title>
        <author>Albert Camus</author>
        <price>10.00</price>
      </book>
    </bookshelf>''';

  // Parse the XML document.
  final document = XmlDocument.parse(bookshelfXml);

  print('--- Bookshelf Contents ---');
  // Find all 'book' elements.
  final books = document.findAllElements('book');
  for (final book in books) {
    final titleElement = book.findElements('title').first;
    final title = titleElement.innerText;
    final author = book.findElements('author').first.innerText;
    final price = book.findElements('price').first.innerText;
    final language = titleElement.getAttribute('lang');

    print('Title:  $title');
    print('Author: $author');
    print('Price:  $price');
    print('Lang:   $language');
    print('-------------------------');
  }

  print('\nQuerying for all book titles:');
  final titles = document
      .findAllElements('title')
      .map((node) => node.innerText);
  print(titles.join(', '));

  print('\nRoot element name: ${document.rootElement.name.local}');
}
