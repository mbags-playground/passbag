import 'package:flutter/material.dart';
import "package:passbags/src/utils/password_generator.dart";
import "package:flutter/services.dart";
import "package:passbags/src/widgets/styled_text_input.dart";

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen>
    with WidgetsBindingObserver {
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
            StyledTextInput(
              controller: secretController,
              text: "Text",
              suffixIcon: GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              isPasswordField: _obscureText,
            ),
            Divider(
              color: Colors.transparent,
            ),
            StyledTextInput(
              controller: passwordController,
              text: 'Password',
            ),
            Divider(
              color: Colors.transparent,
            ),
            ElevatedButton(
              onPressed: generateEncryptedPassword,
              child: const Text("Make my password strong"),
            ),
            Divider(
              color: Colors.transparent,
            ),
            if (encryptedPassword != "")
              Column(
                children: [
                  const Text(
                    'You strong password is Password:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    encryptedPassword,
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _copyToClipboard(
                          encryptedPassword); // Call the copy function here
                    },
                    child: const Text("Copy to Clipboard"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
