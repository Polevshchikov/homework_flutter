import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User> signUp(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() {
    return _fAuth.signOut();
  }

  Future<User> updateUser({displayName, photoURL}) async {
    User _user = FirebaseAuth.instance.currentUser;
    await _user.updateProfile(photoURL: photoURL);
    await _user.updateProfile(displayName: displayName);
    await _user.reload();
    User updatedUser = FirebaseAuth.instance.currentUser;
    return updatedUser;
  }
}
