import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/providers/core_providers.dart';
import 'package:learnbook/features/auth/presentation/screens/login_screen.dart';
import 'package:learnbook/features/home/presentation/screens/home_screen.dart';


class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authCheckProvider);

    return authState.when(
      data: (isLoggedIn) {
        if (isLoggedIn) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
      error: (error, stackTrace) => const LoginScreen(),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
