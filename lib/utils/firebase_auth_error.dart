import 'package:firebase_auth/firebase_auth.dart';

String getErrorMessage(FirebaseAuthException error) {
  switch (error.code) {
    case "invalid-email":
      return "Your email address appears to be malformed.";
    case "wrong-password":
      return "Invalid username or password.";
    case "user-not-found":
      return "User with this email doesn't exist.";
    case "user-disabled":
      return "User with this email has been disabled.";
    case "too-many-requests":
      return "Too many requests. Try again later.";
    case "operation-not-allowed":
      return "Signing in with Email and Password is not enabled.";
    default:
      return "An undefined error happened.";
  }
}
