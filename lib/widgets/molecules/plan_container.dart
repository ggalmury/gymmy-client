import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';

class PlanContainer extends StatefulWidget {
  final String workoutName;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const PlanContainer(
      {super.key,
      required this.workoutName,
      required this.onUpdate,
      required this.onDelete});

  @override
  State<PlanContainer> createState() => _PlanContainerState();
}

class _PlanContainerState extends State<PlanContainer> {
  bool _updateToggle = false;

  void _setUpdateToggle() {
    setState(() {
      _updateToggle = !_updateToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _setUpdateToggle,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColor.grey1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRect(
                          child: Image.asset(
                            "assets/images/exercise/${widget.workoutName}.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.workoutName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: List.generate(
                                workouts[widget.workoutName]?.length ?? 0,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.grey3,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Text(
                                          workouts[widget.workoutName]![index],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      _updateToggle
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 25,
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                width: double.infinity,
                height: _updateToggle ? 50 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Row(
                  children: [
                    Expanded(
                      child: TextBtn(
                        label: "삭제",
                        onPressed: widget.onDelete,
                        fontColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryBtn(
                        label: "정보",
                        onPressed: widget.onUpdate,
                        widgetColor: WidgetColor.appColor,
                        widgetSize: WidgetSize.small,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
