import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';

extension DashboardTaskCardControllerX on DashboardController {
  void removeTaskCard() {
    taskCardModel.removeAt(0);
  }
}
