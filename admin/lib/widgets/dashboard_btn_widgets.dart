import 'package:admin/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class DashboardBtnWidgets extends StatelessWidget {
  final String title, imagePath;
  final Function onPressed;
  const DashboardBtnWidgets(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            SubtitleText(
              label: title,
              fS: 18,
            )
          ],
        ),
      ),
    );
  }
}
