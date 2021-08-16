import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = StateNotifierProvider<AuthService, User?>(
  (ref) => AuthService(),
);

class SignInAbortedException implements Exception {
  const SignInAbortedException();

  @override
  String toString() => 'Sign in aborted';
}

class AuthService extends StateNotifier<User?> {
  AuthService() : super(null);

  bool get isSignedIn => state != null;

  /// Might throw [SignInAbortedException] or [FirebaseAuthException].
  Future<void> signIn() async {
    final user = await GoogleSignIn().signIn(); // triggers auth flow
    if (user == null) {
      throw const SignInAbortedException();
    }

    final auth = await user.authentication;
    final creds = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(creds);
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    state = FirebaseAuth.instance.currentUser;
  }
}
