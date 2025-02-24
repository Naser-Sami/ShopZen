import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  static final _key = Key.fromUtf8('16CharactersKey!!'); // 16/24/32 chars key
  static final _iv = IV.fromLength(16);

  static String encrypt(String text) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.encrypt(text, iv: _iv).base64;
  }

  static String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.decrypt64(encryptedText, iv: _iv);
  }
}
