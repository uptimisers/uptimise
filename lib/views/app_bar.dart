import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user.dart';
import 'home/menu.dart';
import 'router/router.dart';

class AppAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppAppBar({Key? key, required this.title, required this.showProfile})
      // ignore: avoid_field_initializers_in_const_classes
      : titleWidget = null,
        super(key: key);

  const AppAppBar.withWidget({Key? key, required this.titleWidget, required this.showProfile})
      // ignore: avoid_field_initializers_in_const_classes
      : title = null,
        super(key: key);

  final String? title;
  final Widget? titleWidget;
  final bool showProfile;

  static const height = 96.0;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final router = ref.watch(routerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        toolbarHeight: height,
        title: titleWidget ?? Text(title!),
        leading: router.canPopSelfOrChildren
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: router.pop,
              )
            : null,
        actions: [
          if (showProfile)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Material(
                  elevation: 8,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.info.photoURL!),
                    radius: 28,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => showHomeMenu(context),
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
