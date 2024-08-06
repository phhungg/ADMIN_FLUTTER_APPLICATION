import 'package:admin/widgets/subtitle_text.dart';
import 'package:admin/widgets/title_text.dart';
import 'package:flutter/material.dart';

class EmptyWidgets extends StatelessWidget {
  final String imagePath, title, subtitle;
  const EmptyWidgets({
    super.key,
    required this.imagePath,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            TitleText(
              label: "Whoops!",
              fS: 40,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            SubtitleText(
              label: title,
              fw: FontWeight.w700,
              fS: 23,
            ),
            const SizedBox(
              height: 10,
            ),
            SubtitleText(
              label: subtitle,
              fw: FontWeight.w500,
              fS: 14,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
