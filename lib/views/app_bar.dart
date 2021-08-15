import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/auth_service.dart';
import 'router/router.dart';
import 'router/router.gr.dart';

class AppAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppAppBar({Key? key, required this.title, required this.showProfile}) : super(key: key);

  final String title;
  final bool showProfile;

  static const height = 96.0;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final router = ref.read(routerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        toolbarHeight: height,
        title: Text(title),
        leading: router.canPopSelfOrChildren
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: router.pop,
              )
            : null,
        actions: [
          if (showProfile && user.data?.value != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Material(
                  elevation: 8,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.data!.value!.photoURL!),
                    radius: 28,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          router.push(const ProfileRoute());
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
