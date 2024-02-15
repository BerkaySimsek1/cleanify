import 'package:cleanify/pages/signuplogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 61, 217, 136)),
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
          bottomAppBarTheme:
              const BottomAppBarTheme(shape: CircularNotchedRectangle())),
      home: LoginScreen(),
    );
  }
}

























//import 'package:flutter/material.dart';
//import 'package:cleanify/pages/homepage.dart';
//
//void main() {
//  runApp(const MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  const MyApp({super.key});
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        debugShowCheckedModeBanner: false,
//        theme: ThemeData(
//            colorScheme: ColorScheme.fromSeed(
//                seedColor: const Color.fromARGB(255, 39, 247, 139)),
//            useMaterial3: true),
//        home: const MyHomePage(title: 'Cleanify'));
//  }
//}
