import 'package:flutter/material.dart';
import 'package:untitled1/screens/homescreen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),),
      title: 'TODO App',
      home: const TodoApp(),
    );
  }
}