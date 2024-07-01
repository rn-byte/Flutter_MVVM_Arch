import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
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
      debugPrint('Value: $value');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
    //notifyListeners();
  }
}
