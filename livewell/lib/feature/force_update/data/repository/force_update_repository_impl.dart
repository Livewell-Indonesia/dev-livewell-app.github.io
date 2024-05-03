import 'package:livewell/core/remote_config/remote_config_service.dart';
import 'package:livewell/feature/force_update/domain/repository/force_update_repository.dart';

class ForceUpdateRepositoryImpl implements ForceUpdateRepository {
  ForceUpdateRepositoryImpl._();

  static ForceUpdateRepositoryImpl getInstance() => ForceUpdateRepositoryImpl._();

  @override
  Future<ForceUpdateStatus> getForceUpdate() async {
    final response = FirebaseRemoteConfigService().forceUpdateStatus;
    return ForceUpdateStatusExtension.fromString(response);
  }
}
