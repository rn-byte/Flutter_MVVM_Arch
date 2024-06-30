import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_mvvm/utils/routes/routes_name.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, RoutesName.home);
              toastMessage('No Internet Connection');
              flushErrorMessage('No internet', context);
              showSnackbar('No internet', context);
            },
            child: const Text("Click Me")),
      ),
    );
  }
}
