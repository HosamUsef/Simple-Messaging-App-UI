import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
     MyApp(
      appTheme: AppTheme(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme;

  const MyApp({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: "Chatter",
        home:  HomeScreen());
  }
}
