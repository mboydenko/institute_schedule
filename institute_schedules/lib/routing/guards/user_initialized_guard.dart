import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/routing/router.gr.dart';

class UserInitializedGuard extends AutoRouteGuard {
  final UserManager userManager;

  UserInitializedGuard(this.userManager) : super();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (userManager.isUserDefined) {
      resolver.next(true);
    } else {
      router.replaceAll([
        const AuthRoute()
      ]);
    }
  }
}
