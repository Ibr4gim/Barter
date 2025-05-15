import 'package:flutter/material.dart';

class OnboardingSlide extends StatefulWidget {
  const OnboardingSlide({super.key});

  @override
  State<OnboardingSlide> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingSlide> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barter'),
        centerTitle: true,
        backgroundColor: const Color(0xFFCA4E80),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    _images[index],
                    key: ValueKey<int>(index),
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          // Индикаторы страниц
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
