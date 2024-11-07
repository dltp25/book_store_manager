import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static Stream<User?> authState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  static Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> updatePassword(String password) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(password);
  }
}
