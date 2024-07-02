import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/colors.dart';
import '../res/compenents/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    _obscureText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, emailFocus, passFocus);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                valueListenable: _obscureText,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: passController,
                    focusNode: passFocus,
                    obscureText: _obscureText.value,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _obscureText.value = !_obscureText.value;
                        },
                        child: Icon(
                          _obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Consumer<AuthViewModel>(
                builder: (context, value, child) {
                  return RoundButton(
                    title: 'Sign Up',
                    loading: value.isLoading,
                    onPress: () {
                      if (emailController.text.toString().isEmpty) {
                        Utils.flushErrorMessage(
                            'Email field cannot be empty', context);
                      } else if (passController.text.toString().isEmpty) {
                        Utils.flushErrorMessage(
                            'Password field cannot be Empty', context);
                      } else if (passController.text.toString().length < 6) {
                        Utils.flushErrorMessage(
                            'Password cannot be less then 6 digit', context);
                      } else {
                        Map data = {
                          'email': emailController.text.toString(),
                          'password': passController.text.toString()
                        };
                        value.signupApi(data, context);
                        debugPrint('Api Hit');
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an Account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutesName.login);
                    },
                    child: const Text(
                      'Login ',
                      style: TextStyle(color: AppColor.buttonColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
