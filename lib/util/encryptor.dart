import 'package:encrypt/encrypt.dart';

class Encryptor {
  static final _encryptor = Encrypter(
    AES(Key.fromBase64('wnhXiuxpZa8Aqm5yTWPAvJ660ZKJV6rDH3eVAfKFz/U=')),
  );
  static final _iv = IV.fromLength(16);

  static String encrypt(String input) =>
      _encryptor.encrypt(input, iv: _iv).base64;
  static String decrypt(String encrypted) =>
      _encryptor.decrypt64(encrypted, iv: _iv);
}
