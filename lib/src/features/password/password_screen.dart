import 'package:flutter/material.dart';
import "package:passbags/src/utils/password_generator.dart";
import "package:flutter/services.dart";

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  final TextEditingController secretController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String encryptedPassword = '';
  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  void generateEncryptedPassword() {
    final secret = secretController.text;
    final password = passwordController.text;
    final encrypted = generatePassword(secret, password);
    setState(() {
      encryptedPassword = encrypted;
    });
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passbags'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: secretController,
              decoration: InputDecoration(
                labelText: 'Secret',
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: generateEncryptedPassword,
              child: const Text("Generate strong password"),
            ),
            ElevatedButton(
              onPressed: () {
                _copyToClipboard(
                    encryptedPassword); // Call the copy function here
              },
              child: const Text("Copy to Clipboard"),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'You strong password is Password:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              encryptedPassword,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
