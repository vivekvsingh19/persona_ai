import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WebAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Google Sign-In instance for web
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Sign in with Google using Firebase
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // For web, use Firebase's built-in Google authentication popup
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      final UserCredential userCredential = await _firebaseAuth.signInWithPopup(
        googleProvider,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Error signing out: $e');
      // Don't rethrow, just log
    }
  }

  /// Get current user
  static User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Get auth state changes
  static Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  /// Sign in with email and password
  static Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Register with email and password
  static Future<UserCredential> registerWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    }
  }
}
