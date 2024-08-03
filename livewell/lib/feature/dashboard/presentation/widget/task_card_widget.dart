import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card.dart';

class TaskCardModel {
  final String title;
  final String description;
  final TaskCardType type;

  TaskCardModel({required this.title, required this.description, required this.type});
}

enum TaskCardType { hydration, nutrition, exercise, sleep, none, mood }

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({super.key});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  final controller = Get.find<DashboardController>();
  var cardPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Obx(() {
          return CardSwiper(
              numberOfCardsDisplayed: 1,
              cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                return TaskCard(
                  taskCardModel: controller.taskCardModel[index],
                );
              },
              cardsCount: controller.taskCardModel.length);
        }),
      ],
    );
  }
}
