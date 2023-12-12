import 'package:encrypt/encrypt.dart';

class Encryptor {
  static final _encryptor = Encrypter(
    AES(Key.fromBase64('wnhXiuxpZa8Aqm5yTWPAvJ660ZKJV6rDH3eVAfKFz/U=')),
  );
  static final _iv = IV.fromLength(16);

  static String encrypt(String input) =>
      // Passing an empty string to encrypt() will throw an exception.
      input.isEmpty ? '' : _encryptor.encrypt(input, iv: _iv).base64;

  static String decrypt(String encoded) =>
      // Passing an empty string to decrypt64() will throw an exception.
      encoded.isEmpty ? '' : _encryptor.decrypt64(encoded, iv: _iv);
}
