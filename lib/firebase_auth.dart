import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignIn(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleRegister(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final User user = result.user!;

    return user;
  }

  Future<void> userAuthListener() async {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }

  Future<bool> checkIfEmailInUse(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (list.isNotEmpty) {
        print('Duplicate email found');
        return false;
      } else {
        print('Fresh email, proceed');
        return true;
      }
    } catch (error) {
      print(error);
      return true;
    }
  }
}
