import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/app_constants.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: '«·„”«⁄œ «·ÿ»Ì «·–ﬂÌ',
      description: '«”√· „”«⁄œ‰« «·–ﬂÌ ⁄‰ √Ì «” ›”«— ÿ»Ì Ê«Õ’· ⁄·Ï ≈Ã«»«  ›Ê—Ì… œﬁÌﬁ…',
      icon: Icons.smart_toy_outlined,
      color: AppConstants.primaryColor,
    ),
    OnboardingData(
      title: 'ÕÃ“ «·„Ê«⁄Ìœ',
      description: '«ÕÃ“ „Ê«⁄Ìœﬂ „⁄ √›÷· «·√ÿ»«¡ »ﬂ· ”ÂÊ·… ÊÌ”—',
      icon: Icons.calendar_month_outlined,
      color: AppConstants.secondaryColor,
    ),
    OnboardingData(
      title: '«·„ﬁ«·«  Ê«·‰’«∆Õ',
      description: '«ﬁ—√ √ÕœÀ «·„ﬁ«·«  Ê«·‰’«∆Õ «·ÿ»Ì… · Õ”Ì‰ ’Õ ﬂ',
      icon: Icons.article_outlined,
      color: AppConstants.accentColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAF7FD), Color(0xFFF4EBFF)],
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => OnboardingPage(data: _onboardingData[index]),
            ),
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _onboardingData.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppConstants.primaryColor,
                      dotColor: Color(0xFFD8CCFF),
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    child: Text(_currentPage == _onboardingData.length - 1 ? '«»œ√ «·¬‰' : '«· «·Ì'),
                  ),
                  if (_currentPage < _onboardingData.length - 1)
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                      child: const Text(' ŒÿÌ'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 160),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.color.withOpacity(0.18),
              boxShadow: [BoxShadow(color: data.color.withOpacity(0.18), blurRadius: 24, offset: const Offset(0, 10))],
            ),
            child: Icon(data.icon, size: 52, color: data.color),
          ),
          const SizedBox(height: 24),
          Text(data.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.textColor), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(data.description, style: const TextStyle(fontSize: 16, color: Color(0xFF5F5C76)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
