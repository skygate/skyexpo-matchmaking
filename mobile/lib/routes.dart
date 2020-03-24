import 'config/routes_config.dart' show AppRoute;
import 'features/auth/containers/after_auth_container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log_in_container.dart' show LogInContainer;
import 'features/auth/widgets/home_widget.dart' show Home;
import 'features/matching/widgets/matching_list_widget.dart' show MatchingList;

final appRoutes = {
  AppRoute.home.value: (context) => Home(),
  AppRoute.logIn.value: (context) => LogInContainer(),
  AppRoute.afterAuth.value: (context) => AfterAuthContainer(),
  AppRoute.matchingList.value: (context) => MatchingList(),
};
