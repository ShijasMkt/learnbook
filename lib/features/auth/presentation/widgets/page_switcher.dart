import 'package:flutter/material.dart';
import 'package:learnbook/core/network/dio_client.dart';
import 'package:learnbook/core/storage/secure_storage_service.dart';
import 'package:learnbook/features/auth/presentation/screens/login_screen.dart';
import 'package:learnbook/features/home/presentation/screens/home_screen.dart';

class PageSwitcher extends StatefulWidget {
  const PageSwitcher({super.key});

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  final SecureStorageService _storage = SecureStorageService();

  late final DioClient _dioClient;

  @override
  void initState() {
    super.initState();
    _dioClient = DioClient(_storage);
  }

  Future<bool> _checkLogin() async {
    final token = await _storage.getToken();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLogin(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return HomeScreen(dio: _dioClient.dio);
        } else {
          return LoginScreen(dio: _dioClient.dio, storage: _storage);
        }
      },
    );
  }
}
