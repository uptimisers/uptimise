import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/classroom/v1.dart';
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
  AuthService() : super(FirebaseAuth.instance.currentUser);
  final _googleSignIn = GoogleSignIn(
    scopes: <String>[
      ClassroomApi.classroomCoursesReadonlyScope,
      ClassroomApi.classroomCourseworkMeReadonlyScope,
      ClassroomApi.classroomAnnouncementsReadonlyScope
    ],
  );

  bool get isSignedIn => state != null;
  ClassroomApi? classroomApi;

  /// Might throw [SignInAbortedException] or [FirebaseAuthException].
  Future<void> signIn() async {
    final user = await _googleSignIn.signIn(); // triggers auth flow
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

  Future<void> classroomInit() async {
    if (await _googleSignIn.signInSilently() != null) {
      classroomApi = ClassroomApi((await _googleSignIn.authenticatedClient())!);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    state = FirebaseAuth.instance.currentUser;
  }
}
