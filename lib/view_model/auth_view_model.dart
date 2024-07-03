import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      debugPrint("Value: ${value['token']}");
      if (value['token'] != '') {
        final userPref = Provider.of<UserViewModel>(context, listen: false);
        userPref.saveUser(UserModel(
          token: value['token'].toString(),
        ));

        Utils.toastMessage('Login Successfull');
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RoutesName.home);
        notifyListeners();
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
