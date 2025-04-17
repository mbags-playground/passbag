import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passbag/src/features/password/password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('hasCompletedOnboarding') ?? false);
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
  }

  void _goToNextPage() async {
    if (_currentPage == _pages.length - 1) {
      await _completeOnboarding();
      // Navigate to the main app screen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PasswordGeneratorScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToMainApp() async {
    await _completeOnboarding();
    // Navigate to the main app screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PasswordGeneratorScreen()),
    );
  }

  final List<Widget> _pages = const [
    OnboardingPage(
      title: 'Welcome to passbag',
      description:
          'Turn your simple passwords into strong ones with Passags - your password strengthening companion!',
      imagePath: 'lib/assets/images/security_1.svg',
    ),
    OnboardingPage(
      title: 'Combine Two Simple Passwords',
      description:
          'Have two easy-to-remember passwords? We\'ll help you combine them into one super strong password!',
      imagePath: 'lib/assets/images/security_2.svg',
    ),
    OnboardingPage(
      title: 'Simple + Simple = Strong',
      description:
          'Keep using passwords you can remember! We\'ll help you merge them together with special tricks to make them much stronger.',
      imagePath: 'lib/assets/images/security_3.svg',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _checkIfShouldNavigate();
  }

  void _checkIfShouldNavigate() async {
    if (!(await shouldShowOnboarding())) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PasswordGeneratorScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _pages.length; i++)
                  if (i == _currentPage) ...[circleIndicator(true)] else
                    circleIndicator(false),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skipToMainApp,
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: _goToNextPage,
                  child: Text(_currentPage == _pages.length - 1
                      ? "Get Started"
                      : "Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget circleIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 6,
      width: isActive ? 30 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(isActive ? 5 : 3),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(imagePath),
              height: 300,
            ),
            SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
