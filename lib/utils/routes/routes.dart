import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view/home_screen.dart';
import 'package:flutter_mvvm/view/login_view.dart';

import '../../view/signup_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Routes defined'),
            ),
          );
        });
    }
  }
}
