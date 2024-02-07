import 'dart:developer';

import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';

class NutricoRepositoryImpl with NetworkModule implements NutricoRepository {
  NutricoRepositoryImpl._();

  static NutricoRepositoryImpl getInstance() => NutricoRepositoryImpl._();
  @override
  Future<Either<Failure, Foods>> getNutrico(PostNutricoParams params) async {
    try {
      final response = await postMethod(Endpoint.nutriCo,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      Log.colorGreen(
          "success get data food history ${response.body['food_type']}");
      final nyoba = FoodsV2.fromJson(json);
      inspect(nyoba);
      List<Servings>? dataServings = [];
      dataServings.add(nyoba.servings!);
      final data = Foods(
          brandName: nyoba.brandName,
          foodName: nyoba.foodName,
          foodDescription: nyoba.foodDescription,
          foodType: nyoba.foodType,
          servings: [nyoba.servings!],
          provider: nyoba.provider);
      inspect(data);
      return Right(data);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, NutricoAsset>> getNutricoAsset() async {
    try {
      final response = await getMethod(
        Endpoint.nutriCoAsset,
      );
      final json = responseHandler(response);
      return Right(NutricoAsset.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}

class FoodsV2 {
  String? foodName;
  String? foodDescription;
  String? foodType;
  String? brandName;
  Servings? servings;
  String? provider;
  String? referenceId;

  FoodsV2(
      {this.foodName,
      this.foodDescription,
      this.foodType,
      this.brandName,
      this.servings,
      this.provider,
      this.referenceId});

  FoodsV2.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    foodDescription = json['food_description'];
    foodType = json['food_type'];
    brandName = json['brand_name'];
    servings =
        json['servings'] != null ? Servings.fromJson(json['servings']) : null;
    provider = json['provider'];
    referenceId = json['reference_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food_name'] = foodName;
    data['food_description'] = foodDescription;
    data['food_type'] = foodType;
    data['brand_name'] = brandName;
    if (servings != null) {
      data['servings'] = servings!.toJson();
    }
    data['provider'] = provider;
    data['reference_id'] = referenceId;
    return data;
  }
}
