import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/widgets/screens/home.dart';
import 'package:gymmy_client/widgets/screens/routine.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final List<Widget> _screens = [
    const Home(),
    const Routine(),
  ];
  int _curIdx = 0;

  void _onItemTapped(int i) {
    setState(() {
      _curIdx = i;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<RoutineBloc>().add(InitRoutineEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _curIdx,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: "루틴",
          ),
        ],
        currentIndex: _curIdx,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }
}
