import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ug/screens/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goals Unlimited',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleSpacing: 1,
            titleTextStyle: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black,
              fontSize: 21,
            ),
            backgroundColor: Color(0xffFECD01),
            elevation: 0,
            foregroundColor: CupertinoColors.black,
            centerTitle: true,
          ),
          scaffoldBackgroundColor: const Color(0xffFECD01),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xffFECD01),
          ),
          useMaterial3: false,
          fontFamily: "Roboto",
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
