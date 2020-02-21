import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedemo/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {
  bool loading = false;
  Either<Failure, FirebaseUser> _fuser;

  Either<Failure, FirebaseUser> get fuser => _fuser;

  void signUp(String email, String password) async {
    setLoading(true);
    await Task(() =>
            AuthenticationService.siginWithEmailAndPassword(email, password))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            return obj as Failure;
          }),
        )
        .run()
        .then((value) => _setFuser(value));
    setLoading(false);
  }

  void _setFuser(Either<Failure, FirebaseUser> post) {
    _fuser = post;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }
}
