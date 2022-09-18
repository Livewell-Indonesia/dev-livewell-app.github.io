import 'package:flutter/material.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Add Food',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 48,
              ),
              Text('Margherita Pizza'),
              Text('1 slice'),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Container(
                    //color: Colors.pink,
                    child: MultipleColorCircle(
                      colorOccurrences: {
                        Colors.red: 70,
                        Colors.green: 15,
                        Colors.blue: 15
                      },
                      height: 100,
                      child:
                          // crete circular container
                          Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '453',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              Text('cal'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              NutritionProgressDescription(
                data: [
                  NutrtionProgressModel(
                      name: 'Carbs',
                      color: Color(0xFFF06736),
                      total: '80 gram',
                      consumed: '70%'),
                  NutrtionProgressModel(
                      name: 'Carbs',
                      color: Color(0xFFF5D25D),
                      total: '80 gram',
                      consumed: '15%'),
                  NutrtionProgressModel(
                      name: 'Carbs',
                      color: Color(0xFFD8F3B1),
                      total: '80 gram',
                      consumed: '15%'),
                ],
                backgroundColor: Colors.transparent,
              ),
              SearchHistoryItem(title: 'Show nutrient facts', callback: () {}),
            ],
          ),
        ));
  }
}
