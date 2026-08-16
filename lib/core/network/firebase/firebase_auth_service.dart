import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  /// Creates a new user account using email and password
  /// Returns the [UserCredential] which contains the user's UID
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs in an existing user using email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sends a password reset link to the provided email
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Signs out the currently logged-in user.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Gets the current logged-in user's ID
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  /* 
  CLASS SUMMARY:
  This class is responsible for all Authentication operations in Rentora. 
  It acts as a wrapper around FirebaseAuth to handle signing up, logging in, 
  password resets, and logging out without exposing the raw Firebase implementation 
  directly to the repositories or the UI.
  */
}
