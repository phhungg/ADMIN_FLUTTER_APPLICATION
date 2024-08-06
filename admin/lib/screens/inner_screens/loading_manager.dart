import 'package:flutter/material.dart';

class LoadingManager extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingManager(
      {super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        ]
      ],
    );
  }
}
