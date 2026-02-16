import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/features/auth/presentation/widgets/page_switcher.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnBook',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff171717),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white
        ),
        textTheme: GoogleFonts.montserratTextTheme()
        
      ),
      home: PageSwitcher(),
    );
  }
}




