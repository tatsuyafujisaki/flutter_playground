// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'package:stack_trace/stack_trace.dart';
import 'package:xml/xml.dart';

void main() async {
  final url = Uri.parse('https://news.google.com/rss');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);

      final title = document.findAllElements('title').first.innerText;
      print('\nFeed Title: $title');
      print('--- Recent News ---');

      final items = document.findAllElements('item');

      for (final item in items.take(10)) {
        final itemTitle = item.findElements('title').first.innerText;
        final pubDate = item.findElements('pubDate').first.innerText;
        final link = item.findElements('link').first.innerText;

        print('Title: $itemTitle');
        print('Date:  $pubDate');
        print('Link:  $link');
        print('---');
      }
    } else {
      print('Failed to fetch RSS feed. Status code: ${response.statusCode}');
    }
  } on Exception catch (error, stackTrace) {
    print(error);
    print(Trace.from(stackTrace).terse);
  }
}
