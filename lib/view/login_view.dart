import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  fieldFocusChange(context, emailFocus, passFocus);
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Email',
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                  );
                },
              ),
              SizedBox(
                height: height * 0.1,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.blue[300])),
                  onPressed: () {
                    //print(value.emailController.toString());
                  },
                  child:
                      //value.loading
                      //  ? const CircularProgressIndicator(
                      //     color: Colors.white,
                      //    )
                      //:
                      const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}