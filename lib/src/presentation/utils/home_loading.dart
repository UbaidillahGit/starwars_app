import 'package:flutter/material.dart';

class HomePageLoading extends StatelessWidget {
  const HomePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset('assets/gif/loading_1.gif'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Calling character...',
          style: TextStyle(fontFamily: 'Starjedi', color: Colors.white),
        )
      ],
    ));
  }
}
