import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyJournalItem extends StatefulWidget {
  final DailyJournalItemModel model;
  const DailyJournalItem({super.key, required this.model});

  @override
  State<DailyJournalItem> createState() => _DailyJournalItemState();
}

class _DailyJournalItemState extends State<DailyJournalItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.model.itemName,
            style: TextStyle(
                color: const Color(0xFF171433),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          10.verticalSpace,
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DailyJournalItemContent(
                    model: widget.model.content[index]);
              },
              separatorBuilder: (context, index) {
                return 10.verticalSpace;
              },
              itemCount: widget.model.content.length)
        ],
      ),
    );
  }
}

class DailyJournalItemContent extends StatefulWidget {
  final DailyJournalItemContentModel model;
  const DailyJournalItemContent({super.key, required this.model});

  @override
  State<DailyJournalItemContent> createState() =>
      _DailyJournalItemContentState();
}

class _DailyJournalItemContentState extends State<DailyJournalItemContent> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.model.type == DailyJournalItemType.nutrition) {
            isExpanded = !isExpanded;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(isExpanded ? 16 : 100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              children: [
                if (widget.model.type == DailyJournalItemType.nutrition)
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: widget.model.onAddTap,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8F01DF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.model.contentName,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF505050),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(":"),
                ),
                Expanded(
                  flex: widget.model.type == DailyJournalItemType.nutrition
                      ? 5
                      : 6,
                  child: Text(widget.model.contentValue,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF8F01DF),
                          fontWeight: FontWeight.w600)),
                ),
                if (widget.model.type == DailyJournalItemType.nutrition)
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                    ),
                  ),
              ],
            ),
            if (isExpanded)
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const Divider()),
            if (isExpanded) itemContent()
          ],
        ),
      ),
    );
  }

  Widget itemContent() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 8.h),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(widget.model.contentDesc[index].contentDescName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF505050),
                            fontWeight: FontWeight.w600)),
                  ),
                  const Spacer(),
                  Text(widget.model.contentDesc[index].contentDescValue,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF505050),
                          fontWeight: FontWeight.w600)),
                ],
              ),
              4.verticalSpace,
              Row(
                children: [
                  Text(widget.model.contentDesc[index].contentServing ?? "",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF505050),
                          fontWeight: FontWeight.w400)),
                  const Spacer(),
                  Text(widget.model.contentDesc[index].contentDuration ?? "",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF505050),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const Divider());
        },
        itemCount: widget.model.contentDesc.length);
  }
}

class DailyJournalItemModel {
  String itemName;
  DailyJournalItemType type;
  List<DailyJournalItemContentModel> content;

  DailyJournalItemModel(
      {required this.type, required this.itemName, required this.content});
}

enum DailyJournalItemType { nutrition, exercise, sleep, water, mood }

class DailyJournalItemContentModel {
  String contentName;
  String contentValue;
  DailyJournalItemType type;
  List<DailyJournalItemContentDescModel> contentDesc;
  VoidCallback? onAddTap;

  DailyJournalItemContentModel(
      {required this.type,
      required this.contentName,
      required this.contentValue,
      required this.contentDesc,
      this.onAddTap});
}

class DailyJournalItemContentDescModel {
  String contentDescName;
  String contentDescValue;
  String? contentServing;
  String? contentDuration;

  DailyJournalItemContentDescModel(
      {required this.contentDescName,
      required this.contentDescValue,
      this.contentServing,
      this.contentDuration});
}
