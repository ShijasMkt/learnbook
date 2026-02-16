import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:learnbook/core/network/api_endpoints.dart';
import 'package:learnbook/core/storage/secure_storage_service.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/features/auth/presentation/providers/phn_num_provider.dart';
import 'package:learnbook/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  final Dio dio;
  final SecureStorageService storage;
  const LoginScreen({super.key, required this.dio, required this.storage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> login(BuildContext context) async {
      final phNum = ref.read(phoneNumProvider);
      if (phNum.isEmpty || phNum.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid number")),
        );
        return;
      }
      try {
        final response = await dio.post(
          ApiEndpoints.otpVerified,
          data: FormData.fromMap({"country_code": "+91", "phone": phNum}),
        );

        final token = response.data['token']['access'];
        await storage.saveToken(token);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(dio: dio)),
        );
      } on DioException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.customSizedBoxHgt(context, 20),
              Text(
                "Enter Your\nMobile Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              context.customSizedBoxHgt(context, 10),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula euismod mi viverra.",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              context.customSizedBoxHgt(context, 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "+91",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        context.customSizedBoxWdt(context, 5),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  context.customSizedBoxWdt(context, 10),

                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      onChanged: (value) {
                        ref.read(phoneNumProvider.notifier).state = value;
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: TextButton(
                    onPressed: () => login(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white24),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        context.customSizedBoxWdt(context, 10),

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
