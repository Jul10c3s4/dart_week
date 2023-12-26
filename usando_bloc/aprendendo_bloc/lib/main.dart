import 'package:flutter/material.dart';
import 'package:usando_bloc/pages/home_page.dart';
import 'package:usando_bloc/pages/home_single_page%20.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   home: HomeSinglePage(),
    );
  }
}
