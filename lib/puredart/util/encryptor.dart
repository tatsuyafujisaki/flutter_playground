import 'package:encrypt/encrypt.dart';

final _encryptor = Encrypter(
  AES(Key.fromBase64('6ZE61Jel3H8bdRNvGz7BGPK2eJWYfczTZgQZRZt9knM=')),
);
final _iv = IV.fromLength(16);

String encrypt(String input) =>
    // Passing an empty string to encrypt() will throw an exception.
    input.isEmpty ? '' : _encryptor.encrypt(input, iv: _iv).base64;

String decrypt(String encoded) =>
    // Passing an empty string to decrypt64() will throw an exception.
    encoded.isEmpty ? '' : _encryptor.decrypt64(encoded, iv: _iv);

void main() {
  const plaintext = 'foo';
  final encrypted = encrypt(plaintext);
  print(encrypted);
  print(decrypt(encrypted));
}
