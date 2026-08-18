import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService(this._firebaseAuth) : _googleSignIn = GoogleSignIn();

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

  /// Handles Google Sign-In Flow
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in with Google was canceled',
      );
    }

    //
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Sends a password reset link to the provided email
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Signs out the currently logged-in user from both Firebase and Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  /// Gets the current logged in user's ID
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  /* 
  CLASS SUMMARY:
  This class is responsible for all Authentication operations in Rentora. 
  It acts as a wrapper around FirebaseAuth to handle signing up, logging in, 
  Google Sign-In, password resets, and logging out without exposing the raw 
  Firebase implementation directly to the repositories or the UI.
  */
}
