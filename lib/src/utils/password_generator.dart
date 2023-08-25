import 'dart:convert';
import "package:crypto/crypto.dart";

String generatePassword(String secret, String password) {
  final hash = cryptoHmacSha256(secret, password);
  final encodedPassword = hexToBase64(hash);
  return encodedPassword;
}

String cryptoHmacSha256(String secret, String data) {
  final hmac = Hmac(sha256, utf8.encode(secret));
  final digest = hmac.convert(utf8.encode(data));
  return digest.toString();
}

String hexToBase64(String hexString) {
  final bytes = hexToBytes(hexString);
  final base64String = base64.encode(bytes);
  return base64String;
}

List<int> hexToBytes(String hexString) {
  final length = hexString.length;
  final bytes = <int>[];

  for (var i = 0; i < length; i += 2) {
    final hexPair = hexString.substring(i, i + 2);
    final byte = int.parse(hexPair, radix: 16);
    bytes.add(byte);
  }

  return bytes;
}
