import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/auth_service.dart';
import '../../services/log_service.dart';
import '../dialog.dart';
import '../router/router.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = ref.watch(loggerProvider);
    final router = ref.watch(routerProvider);
    final auth = ref.watch(authProvider);

    Future<void> signIn() async {
      try {
        await auth.signIn();
      } on SignInAbortedException {
        return;
      } on FirebaseAuthException catch (e, s) {
        final message = e.message ?? 'An authentication error occured. Please try again.';
        await showExceptionDialog(context, message, e, s, ref);
        return;
      } catch (e, s) {
        await showErrorDialog(context, e, s, ref);
        return;
      }

      final user = ref.read(userProvider).data!.value!;
      log.i('${user.displayName} (${user.email}) signed in');
      final path = router.current.queryParams.get('to', '/') as String;
      await router.replaceNamed(path);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/backdrop.png', fit: BoxFit.cover),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width, // to allow centering
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Text(
                    'Start Uptimising',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: const Color(0xFFF3F6FF)),
                  ),
                  const SizedBox(height: 32),
                  if (kIsWeb || !Platform.isMacOS) GoogleSignInButton(onTap: signIn),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset('assets/images/google_icon.png', height: 18),
              const SizedBox(width: 24),
              Text(
                'Sign in with Google',
                style: Theme.of(context).textTheme.button!.copyWith(color: const Color(0xFF777B83)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
