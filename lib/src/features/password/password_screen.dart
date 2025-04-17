import 'package:flutter/material.dart';
import "package:passbag/src/utils/password_generator.dart";
import "package:flutter/services.dart";
import "package:passbag/src/widgets/styled_text_input.dart";

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void generateEncryptedPassword() {
    final secret = secretController.text;
    final password = passwordController.text;
    final encrypted = generatePassword(secret, password);
    setState(() {
      encryptedPassword = encrypted;
    });
  }

  void _showOnboardingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to Use'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('1. Enter your secret phrase'),
                Text('2. Enter a base password'),
                Text('3. Click "Make my password strong" to generate'),
                Text('4. Copy your strong password'),
                SizedBox(height: 16),
                Text('Tips:'),
                Text('• Keep your secret phrase safe'),
                Text('• Use different base passwords for different services'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Passbag'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('Passbag - Password Generator'),
                SizedBox(height: 8),
                Text('Version: 0.0.1'),
                SizedBox(height: 16),
                Text('Developer: Sostene Munezero Bagira'),
                Text('Released as open source software'),
                SizedBox(height: 16),
                Text('Dependencies:'),
                Text('• flutter: sdk: flutter'),
                Text('• cupertino_icons'),
                Text('• flutter_svg'),
                Text('• shared_preferences'),
                Text('• flutter_launcher_icons'),
                // Add other dependencies as needed
                SizedBox(height: 16),
                Text(
                    'This app helps you generate strong, unique passwords using your secret phrase and base password.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('View Licenses'),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: 'Passbag',
                  applicationVersion: '1.0.0',
                );
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _hideSecret = true;
  bool _hidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _toggleSecretVisibility() {
    setState(() {
      _hideSecret = !_hideSecret;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('passbag'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showOnboardingDialog,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showAboutDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledTextInput(
              controller: secretController,
              text: "Secret",
              suffixIcon: GestureDetector(
                onTap: _toggleSecretVisibility,
                child: Icon(
                  _hideSecret ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              isPasswordField: _hideSecret,
            ),
            const Divider(color: Colors.transparent),
            StyledTextInput(
              controller: passwordController,
              text: 'Password',
              suffixIcon: GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              isPasswordField: _hidePassword,
            ),
            const Divider(color: Colors.transparent),
            ElevatedButton(
              onPressed: generateEncryptedPassword,
              child: const Text("Make my password strong"),
            ),
            const Divider(color: Colors.transparent),
            if (encryptedPassword != "")
              Column(
                children: [
                  const Text(
                    'Your strong password is:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    encryptedPassword,
                    style: const TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () => _copyToClipboard(encryptedPassword),
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
