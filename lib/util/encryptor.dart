import 'package:encrypt/encrypt.dart';

class Encryptor {
  static final _encryptor = Encrypter(
    AES(Key.fromBase64('wnhXiuxpZa8Aqm5yTWPAvJ660ZKJV6rDH3eVAfKFz/U=')),
  );
  static final _iv = IV.fromLength(16);

  // Passing an empty string to encrypt() will throw an exception.
  static String encrypt(String input) =>
      input.isEmpty ? '' : _encryptor.encrypt(input, iv: _iv).base64;

  // Passing an empty string to decrypt64() will throw an exception.
  static String decrypt(String encoded) =>
      encoded.isEmpty ? '' : _encryptor.decrypt64(encoded, iv: _iv);
}
