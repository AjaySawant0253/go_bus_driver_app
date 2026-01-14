import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';

class EncryptionHelper {
  String generateSignature(String url, String timestamp, String secretKey) {
    final content = '$url|$timestamp';
    final key = utf8.encode(secretKey);
    final bytes = utf8.encode(content);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return digest.toString();
  }

  String encryptAES(String plainText, String base64Key) {
    final key = encrypt.Key.fromBase64(base64Key);
    final iv = encrypt.IV.fromSecureRandom(16);

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final combined = iv.bytes + encrypted.bytes;

    return base64.encode(combined);
  }

  String? decryptAES(String encryptedBase64, String base64Key) {
    try {
      final encryptedBytes = base64.decode(encryptedBase64);
      final iv = encrypt.IV(Uint8List.fromList(encryptedBytes.sublist(0, 16)));
      final cipherTextBytes = encryptedBytes.sublist(16);

      final key = encrypt.Key.fromBase64(base64Key);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc),
      );

      final decrypted = encrypter.decrypt(
        encrypt.Encrypted(Uint8List.fromList(cipherTextBytes)),
        iv: iv,
      );

      return decrypted;
    } catch (e) {
      return null;
    }
  }
}
