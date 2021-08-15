import 'package:flutter/material.dart';

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
