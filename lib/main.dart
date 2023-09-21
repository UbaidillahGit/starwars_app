import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/core/injection/http_injection.dart';
import 'package:starwars_app/src/presentation/splash_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ///_____ This widget is the root of our application.
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashPage()
    );
  }
}
