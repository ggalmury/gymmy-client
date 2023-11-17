import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  final String title;
  final Widget child;
  final bool? disablePaddingTop;

  const Base(
      {super.key,
      required this.title,
      required this.child,
      this.disablePaddingTop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: disablePaddingTop == true
              ? const EdgeInsets.symmetric(horizontal: 20)
              : const EdgeInsets.all(25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
