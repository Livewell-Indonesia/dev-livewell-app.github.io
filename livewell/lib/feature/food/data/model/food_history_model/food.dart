import 'package:equatable/equatable.dart';

import 'serving.dart';

class Food extends Equatable {
  final String? foodName;
  final String? foodDescription;
  final String? foodType;
  final String? brandName;
  final List<Serving>? servings;
  final String? provider;

  const Food({
    this.foodName,
    this.foodDescription,
    this.foodType,
    this.brandName,
    this.servings,
    this.provider,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodName: json['food_name'] as String?,
        foodDescription: json['food_description'] as String?,
        foodType: json['food_type'] as String?,
        brandName: json['brand_name'] as String?,
        servings: (json['servings'] as List<dynamic>?)
            ?.map((e) => Serving.fromJson(e as Map<String, dynamic>))
            .toList(),
        provider: json['provider'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'food_name': foodName,
        'food_description': foodDescription,
        'food_type': foodType,
        'brand_name': brandName,
        'servings': servings?.map((e) => e.toJson()).toList(),
        'provider': provider,
      };

  Food copyWith({
    String? foodName,
    String? foodDescription,
    String? foodType,
    String? brandName,
    List<Serving>? servings,
    String? provider,
  }) {
    return Food(
      foodName: foodName ?? this.foodName,
      foodDescription: foodDescription ?? this.foodDescription,
      foodType: foodType ?? this.foodType,
      brandName: brandName ?? this.brandName,
      servings: servings ?? this.servings,
      provider: provider ?? this.provider,
    );
  }

  @override
  List<Object?> get props {
    return [
      foodName,
      foodDescription,
      foodType,
      brandName,
      servings,
      provider,
    ];
  }
}
