import 'package:flutter/material.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';

class DetailInfoField extends StatelessWidget {
  const DetailInfoField({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText().starjediWhite(txt: title),
        SizedBox(width: 150, child: CustomText().starjediWhite(txt: value, textAlign: TextAlign.end))
      ],
    );
  }
}
