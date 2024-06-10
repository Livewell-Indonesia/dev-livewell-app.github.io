import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';

class PostNutrico extends UseCase<Foods, PostNutricoParams> {
  late NutricoRepository repository;

  PostNutrico.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Foods>> call(PostNutricoParams params) async {
    if (params.imageUrl.isEmpty) {
      return await repository.getNutrico(params);
    } else {
      return await repository.getNutricoV2(params);
    }
  }
}

class PostNutricoParams {
  final String description;
  final String imageUrl;
  final String refId;

  PostNutricoParams(this.description, this.imageUrl, this.refId);

  Map<String, dynamic> toJson() {
    return {
      'name': description,
      'image_url': imageUrl,
      'original_search_reference_id': refId,
    };
  }
}
