import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  // String _token = '';

  // String get token => _token;

  // void setToken(String value) {
  //   _token = value;
  // }

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    debugPrint('TOKEN $token');

    return UserModel(
      token: token.toString(),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

  // Future<void> getData() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   String? tokenVal = sp.getString('token');
  //   setToken(tokenVal!);
  //   debugPrint('HOME TOKEN: $token');
  //   notifyListeners();
  // }
}
