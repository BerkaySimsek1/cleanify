import 'package:cleanify/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      String res = "Some error occured"}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        AppUser user = AppUser(
            email: email,
            password: password,
            username: username,
            uid: cred.user!.uid);
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Success";
        return res;
      }
    } catch (error) {
      res = error.toString();
      return res;
    }
    return res;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
