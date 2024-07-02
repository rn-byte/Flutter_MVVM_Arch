import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool isLoading = false;

  bool get loading => isLoading;
  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      debugPrint("Value: ${value['token']}");
      if (value['token'] != '') {
        //UserViewModel.sa
        //Utils.flushErrorMessage('Login Successfull', context);
        Utils.toastMessage('Login Successfull');
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        Utils.flushErrorMessage('Email or Password is incorrect', context);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.registerApi(data).then((value) {
      setLoading(false);
      debugPrint("Value: $value");
      if (value['token'] != '') {
        Utils.toastMessage('Register Successfull');
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Utils.flushErrorMessage('Email or Password is incorrect', context);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }
}
