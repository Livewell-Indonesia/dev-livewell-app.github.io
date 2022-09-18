import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/food/presentation/controller/add_meal_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/scan_barcode_screen.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class AddMealScreen extends StatefulWidget {
  final MealTime time;

  AddMealScreen({Key? key, required this.time}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen>
    with TickerProviderStateMixin {
  final AddMealController controller = Get.put(AddMealController());
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 3, vsync: this);
    return LiveWellScaffold(
      title: widget.time.appBarTitle(),
      body: Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            searchBar(),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: searchInitial())
            // TabBar(
            //   controller: controller,
            //   labelColor: const Color(0xFF171433),
            //   unselectedLabelColor: const Color(0xFF171433).withOpacity(0.3),
            //   indicatorWeight: 2.0,
            //   indicatorPadding: EdgeInsets.zero,
            //   indicator: const BubbleTabIndicator(
            //     indicatorHeight: 35.0,
            //     indicatorColor: Color(0xFFD8F3B1),
            //     tabBarIndicatorSize: TabBarIndicatorSize.tab,
            //   ),
            //   isScrollable: true,
            //   tabs: const [
            //     Tab(
            //       text: "All",
            //     ),
            //     Tab(
            //       text: "Local F&B",
            //     ),
            //     Tab(
            //       text: "Brand Name",
            //     ),
            //   ],
            // ),
            // Expanded(
            //   child: TabBarView(
            //     controller: controller,
            //     children: [
            //       Column(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               color: Colors.red,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               color: Colors.green,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               color: Colors.blue,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView searchInitial() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: scanButton(ScanType.barcode, () {
                  Get.to(() => ScanBarcodeScreen(type: ScanType.barcode),
                      transition: Transition.leftToRight);
                })),
                const SizedBox(width: 24),
                Expanded(
                    child: scanButton(ScanType.photo, () {
                  Get.to(() => ScanBarcodeScreen(type: ScanType.photo),
                      transition: Transition.leftToRight);
                })),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('History'),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {
              Get.to(() => AddFoodScreen(), transition: Transition.leftToRight);
            },
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {},
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {},
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {},
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {},
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {},
          ),
          SearchHistoryItem(
            title: 'Margherita Pizza - Dominos',
            callback: () {
              Get.to(() => FoodScreen(), transition: Transition.leftToRight);
            },
          ),
        ],
      ),
    );
  }

  Container searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        focusNode: controller.focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 20, bottom: 16),
          border: InputBorder.none,
          hintText: 'Search here...',
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          prefixIcon: Image.asset(
            Constant.icSearch,
            scale: 1,
          ),
        ),
      ),
    );
  }

  Widget scanButton(ScanType type, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            const EdgeInsets.only(top: 15, left: 18, bottom: 12, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                type.asset(),
                width: 30,
                height: 30,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 32),
            Text(type.title())
          ],
        ),
      ),
    );
  }
}

class SearchHistoryItem extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  const SearchHistoryItem(
      {Key? key, required this.title, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(title),
            Spacer(),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum ScanType {
  barcode,
  photo,
}

extension ScanTypeAtt on ScanType {
  String title() {
    switch (this) {
      case ScanType.barcode:
        return 'Scan a barcode';
      case ScanType.photo:
        return 'Scan a meal';
    }
  }

  String asset() {
    switch (this) {
      case ScanType.barcode:
        return Constant.icBarcode;
      case ScanType.photo:
        return Constant.icScanMeal;
    }
  }
}
