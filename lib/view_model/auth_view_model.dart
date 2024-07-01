import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo.loginApi(data).then((value) {
      debugPrint('Value' + value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils.toastMessage(error.toString());
    });
    notifyListeners();
  }
}
