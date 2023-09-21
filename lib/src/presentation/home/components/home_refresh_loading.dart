import 'package:flutter/material.dart';

class HomePageRefreshLoading extends StatelessWidget {
  const HomePageRefreshLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Loading...', style: TextStyle(fontFamily: 'Starjedi', color: Colors.white)),
          const SizedBox(width: 10),
          Image.asset('assets/gif/droid_2.gif'),
        ],
      ),
    );
  }
}
