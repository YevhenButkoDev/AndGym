import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:module_gym/service/HttpService.dart';

class AuthService extends HttpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User cancelled

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final response = await authorisedPost("/api/register", jsonEncode({
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName
      }));
      if (response.statusCode != 200) {
        throw Exception("Failed to register");
      }
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        throw Exception("Please verify your email before signing in.");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception("Failed to sign in");
    }
  }


  Future<String> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        return 'Verification email sent. Please check your inbox.';
      }

      return 'Account Created';
    } on FirebaseAuthException catch (e) {
      throw Exception("Failed to register");
    }
  }
}