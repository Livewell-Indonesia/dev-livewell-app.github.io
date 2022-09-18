import 'package:equatable/equatable.dart';

import 'food.dart';

class FoodHistoryModel extends Equatable {
  final List<Food>? foods;

  const FoodHistoryModel({this.foods});

  factory FoodHistoryModel.fromJson(Map<String, dynamic> json) {
    return FoodHistoryModel(
      foods: (json['foods'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'foods': foods?.map((e) => e.toJson()).toList(),
      };

  FoodHistoryModel copyWith({
    List<Food>? foods,
  }) {
    return FoodHistoryModel(
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props => [foods];
}
