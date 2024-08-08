import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_task_card_controller.dart';
import 'package:livewell/feature/dashboard/presentation/enums/task_card_type.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card.dart';

class TaskCardModel {
  final String title;
  final String description;
  final TaskCardType type;

  TaskCardModel({required this.title, required this.description, required this.type});
}

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({super.key});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  final controller = Get.find<DashboardController>();
  var cardPosition = 0.0;
  var cardSwiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Obx(() {
          return CardSwiper(
              numberOfCardsDisplayed: 1,
              controller: cardSwiperController,
              cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                return TaskCard(
                  taskCardModel: controller.taskCardModel[index],
                  onNextTap: () {
                    cardSwiperController.moveTo(index + 1);
                  },
                  onPrevTap: () {
                    cardSwiperController.moveTo(index - 1);
                  },
                  onDoneTap: () {
                    controller.removeTaskCard();
                  },
                );
              },
              cardsCount: controller.taskCardModel.length);
        }),
      ],
    );
  }
}
