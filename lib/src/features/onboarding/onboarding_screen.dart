import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passbag/src/features/password/password_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // Track the current active page

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage == _pages.length - 1) {
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

  void _skipToMainApp() {
    // Navigate to the main app screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PasswordGeneratorScreen()),
    );
  }

  final List<Widget> _pages = const [
    OnboardingPage(
      title: 'Welcome to Passags',
      description:
          'Discover Passags – the tool that turns weak passwords into super strong ones!',
      imagePath: 'lib/assets/images/security_1.svg',
    ),
    OnboardingPage(
      title: 'One Mighty Secret is All You Need',
      description:
          'Imagine having one super strong secret. It’s like a magic key that helps you create super strong passwords.',
      imagePath: 'lib/assets/images/security_2.svg',
    ),
    OnboardingPage(
      title: 'Stronger Passwords, No Sweat',
      description:
          'Whether your password is weak or strong, we make it even stronger. Just give us your secret, and we’ll mix it up for super safety.',
      imagePath: 'lib/assets/images/security_3.svg',
    ),
    // Add more OnboardingPage widgets here

    // Add more OnboardingPage widgets here
  ];

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
                  child: Text("Next"),
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
        shape: BoxShape.circle,
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
