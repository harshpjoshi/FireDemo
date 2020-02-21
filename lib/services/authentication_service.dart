import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedemo/models/user.dart';
import 'package:firedemo/services/firestore_user_service.dart';

class AuthenticationService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<FirebaseUser> siginWithEmailAndPassword(
      String email, String password) async {
    AuthResult result;
    FirestoreUserService firestoreUserService;
    try {
      result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      print('signInEmail succeeded: $user');
      firestoreUserService = FirestoreUserService(user.uid);
      firestoreUserService.setUser(User(user.displayName,user.email,user.uid));
      return user;
    } catch (e) {
      print(e);
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          throw Failure("Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          throw Failure( "Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          throw Failure("User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          throw Failure("User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          throw Failure("Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          throw Failure("Signing in with Email and Password is not enabled.");
          break;
        default:
          throw Failure("An undefined Error happened.");
      }
    }
  }
}

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
