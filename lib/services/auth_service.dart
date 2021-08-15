import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());
final userProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final userDocProvider = Provider<DocumentReference?>((ref) {
  final uid = ref.watch(userProvider).map<String?>(
        data: (data) => data.value?.uid,
        loading: (_) => null,
        error: (_) => null,
      );
  if (uid != null) {
    return FirebaseFirestore.instance.collection('users').doc(uid);
  } else {
    return null;
  }
});

class SignInAbortedException implements Exception {
  const SignInAbortedException();

  @override
  String toString() => 'Sign in aborted';
}

class AuthService {
  bool get isSignedIn => FirebaseAuth.instance.currentUser != null;

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
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
