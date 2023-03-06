import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

class GetPopupAssets extends UseCase<PopupAssetsModel, NoParams> {
  late DashBoardRepository repository;
  GetPopupAssets.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, PopupAssetsModel>> call(NoParams params) async {
    return await repository.getPopupAssets();
  }
}
