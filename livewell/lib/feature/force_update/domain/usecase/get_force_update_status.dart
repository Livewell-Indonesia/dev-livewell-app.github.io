import 'package:livewell/feature/force_update/data/repository/force_update_repository_impl.dart';
import 'package:livewell/feature/force_update/domain/repository/force_update_repository.dart';

class GetForceUpdateStatus {
  late ForceUpdateRepository repository;

  GetForceUpdateStatus.instance() {
    repository = ForceUpdateRepositoryImpl.getInstance();
  }

  Future<ForceUpdateStatus> call() async {
    return await repository.getForceUpdate();
  }
}
