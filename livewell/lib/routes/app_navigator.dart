import 'package:livewell/feature/auth/presentation/page/login/login_screen.dart';
import 'package:livewell/routes/page_route_fade.dart';

class AppNavigator {
  static PageRouteFade login() => PageRouteFade(LoginScreen(), 1000);
}
