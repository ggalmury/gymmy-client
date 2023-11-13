import 'package:flutter/material.dart';

import 'package:gymmy_client/widgets/layouts/base.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Base(
      title: "오늘의 루틴",
      child: Center(
        child: Text("홈"),
      ),
    );
  }
}
