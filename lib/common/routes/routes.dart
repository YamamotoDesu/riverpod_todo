import 'package:flutter/material.dart';
import 'package:riverpod_todo/features/auth/pages/login_page.dart';
import 'package:riverpod_todo/features/auth/pages/otp_page.dart';
import 'package:riverpod_todo/features/todo/pages/home_page.dart';

import '../../features/onboarding/pages/onboarding_page.dart';

class RouteGenerator {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => OtpPage(
            phone: args['phone'],
            smsCodeId: args['smsCodeId'],
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
