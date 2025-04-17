import 'package:flutter/material.dart';
import 'package:passbags/src/features/onboarding/onboarding_screen.dart';
import 'package:passbags/src/features/password/password_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passbag',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
      ],
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 175, 255, 63)),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}
