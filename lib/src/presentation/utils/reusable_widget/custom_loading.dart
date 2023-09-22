import 'package:flutter/material.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';

class CustomLoadingOne extends StatelessWidget {
  const CustomLoadingOne({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/gif/loading_3.gif', height: 130),
        const SizedBox(height: 20),
        CustomText().starjediWhite(txt: title)
      ],
    );
  }
}
