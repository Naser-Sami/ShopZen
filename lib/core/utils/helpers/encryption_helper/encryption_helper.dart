import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  static final _key = Key.fromSecureRandom(32); // 16-byte (128-bit)
  static final _iv = IV.fromLength(16); // 16-byte IV (Initialization Vector)

  static String encrypt(String text) {
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc)); // Use CBC mode
    return encrypter.encrypt(text, iv: _iv).base64;
  }

  static String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return encrypter.decrypt64(encryptedText, iv: _iv);
  }
}
