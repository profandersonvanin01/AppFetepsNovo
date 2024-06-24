import 'package:feteps/SplashScreen_page.dart';
// import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feteps 2024',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //parametros para o calendario funcionar
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      home: const SplashScreenPage(),
    );
  }
}
