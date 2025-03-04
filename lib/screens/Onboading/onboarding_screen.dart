import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ug/components/Onboading/onboarding_button.dart';
import 'package:ug/screens/Login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {});
        },
        children: [
          _buildWelcomeScreen(),
          _buildSetGoalsScreen(),
          _buildTrackAchieveScreen(),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return _buildScreenContent(
      animationPath: 'assets/animations/welcome.json',
      title: "Welcome to Goals Unlimited – Turn Your Dreams into Reality!",
      description: "Your journey to achieving your dreams starts here.",
      buttonText: "Welcome User",
      onPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
    );
  }

  Widget _buildSetGoalsScreen() {
    return _buildScreenContent(
      animationPath: 'assets/animations/goals.json',
      title: "Set Your Goals – Daily, Weekly, or Lifetime Targets",
      description: "Organize your dreams into actionable goals.",
      buttonText: "Set Your Goals",
      onPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
    );
  }

  Widget _buildTrackAchieveScreen() {
    return _buildScreenContent(
      animationPath: 'assets/animations/progress.json',
      title: "Track Your Progress – Stay Consistent, Stay Motivated",
      description: "Monitor your achievements and stay on track.",
      buttonText: "Get Started",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      },
    );
  }

  Widget _buildScreenContent({
    required String animationPath,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffFECD01),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 350, // Fixed width for square box
            height: 350, // Fixed height for square box

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(animationPath),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          OnboardingButton(
            buttonText: buttonText,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
