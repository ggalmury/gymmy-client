import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final List<String> hours = List.generate(
      14, (index) => index == 0 || index == 13 ? " " : index.toString());
  final List<String> minutes = List.generate(
      14,
      (index) =>
          index == 0 || index == 13 ? " " : ((index - 1) * 5).toString());
  final List<String> ap = [" ", "오전", "오후", " "];

  @override
  Widget build(BuildContext context) {
    double width = 250;

    return SizedBox(
      width: width,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            width: width,
            height: 50,
            top: 50,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.grey1,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Cell(list: ap),
              _Cell(list: hours),
              _Cell(list: minutes),
            ],
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatefulWidget {
  final List list;

  const _Cell({super.key, required this.list});

  @override
  State<_Cell> createState() => __CellState();
}

class __CellState extends State<_Cell> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: widget.list.length * 50,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.list.length,
            itemBuilder: (context, index) => SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  widget.list[index].toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
