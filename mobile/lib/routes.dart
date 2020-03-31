import 'config/routes_config.dart' show AppRoute;
import 'features/auth/containers/after_auth_container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log_in_container.dart' show LogInContainer;
import 'features/auth/containers/register_container.dart'
    show RegisterContainer;
import 'features/auth/widgets/home_widget.dart' show Home;
import 'features/matching/containers/matching_list_container.dart'
    show MatchingListContainer;

final appRoutes = {
  AppRoute.home.value: (context) => Home(),
  AppRoute.logIn.value: (context) => LogInContainer(),
  AppRoute.register.value: (context) => RegisterContainer(),
  AppRoute.afterAuth.value: (context) => AfterAuthContainer(),
  AppRoute.matchingList.value: (context) => MatchingListContainer(),
  AppRoute.calendar.value: (context) => MatchingListContainer(),
  AppRoute.notifications.value: (context) => MatchingListContainer(),
  AppRoute.settings.value: (context) => MatchingListContainer(),
};
