import 'config/routes_config.dart' show AppRoute;
import 'features/auth/containers/after-auth.container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log-in.container.dart' show LogInContainer;
import 'features/auth/widgets/home.widget.dart' show Home;
import 'features/matching/widgets/matching-list.widget.dart' show MatchingList;

final appRoutes = {
  AppRoute.home.value: (context) => Home(),
  AppRoute.logIn.value: (context) => LogInContainer(),
  AppRoute.afterAuth.value: (context) => AfterAuthContainer(),
  AppRoute.matchingList.value: (context) => MatchingList(),
};
