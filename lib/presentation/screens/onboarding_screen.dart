import 'package:Barter/presentation/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSlide extends StatefulWidget {
  const OnboardingSlide({super.key});

  @override
  State<OnboardingSlide> createState() => _OnboardingSlideState();
}

class _OnboardingSlideState extends State<OnboardingSlide> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'assets/images/duck.png',
    'assets/images/duck.png',
    'assets/images/duck.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() async {
    if (_currentPage < _images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_completed', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  void _skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barter', style: TextStyle(fontFamily: 'Orbitron')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Image.asset(
                    _images[index],
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 12.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? const Color(0xFFCA4E80)
                          : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _goToNextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCA4E80),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              _currentPage == _images.length - 1 ? 'Начать' : 'Далее',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: _skipOnboarding,
            child: const Text(
              'Пропустить',
              style: TextStyle(color: Color(0xFFCA4E80)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
