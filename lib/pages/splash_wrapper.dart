import 'package:flutter/material.dart';

import 'auth_state_handler.dart';
import 'onboarding_screen.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    //Show splash screen for 1 second
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Create a beautiful slide+fade transition animation when navigating to AuthStateHandler (login/home screen)
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        final slide = Tween(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
      child: _showSplash
          ? const OnboardingScreen(key: ValueKey('splash'))
          : const AuthStateHandler(key: ValueKey('auth')),
    );
  }
}
