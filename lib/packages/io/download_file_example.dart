import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<Uint8List> downloadBinaryFile(String url) async {
  bool isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  final response = await http.get(Uri.parse(url));
  if (isSuccessful(response.statusCode)) {
    return response.bodyBytes;
  }
  throw Exception(
    '''Status code: ${response.statusCode}\nReason phrase: ${response.reasonPhrase}\nURL: $url''',
  );
}

Future<String> downloadTextFile(Uri uri) async {
  bool isSuccessful(int statusCode) => 200 <= statusCode && statusCode <= 299;

  final response = await http.get(uri);
  if (isSuccessful(response.statusCode)) {
    return response.body;
  }
  throw Exception(
    '''Status code: ${response.statusCode}\nReason phrase: ${response.reasonPhrase}\nURL: $uri''',
  );
}
