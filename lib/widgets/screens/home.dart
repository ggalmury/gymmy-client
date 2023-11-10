import 'package:flutter/material.dart';

import 'package:gymmy_client/widgets/templates/base.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
