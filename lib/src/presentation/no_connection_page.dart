import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/main.dart';

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  Future<bool> _willPopCallback(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MyApp()), 
      (route) => false
    );
    return true; // return true if the route to be popped
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        body: Center(child: Image.asset('assets/gif/no_internet.gif')),
      ),
    );
  }
}