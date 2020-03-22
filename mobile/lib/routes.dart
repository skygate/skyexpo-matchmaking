import 'config/routes_config.dart' show AppRoute;
import 'features/auth/containers/after-auth.container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log-in.container.dart' show LogInContainer;
import 'features/auth/widgets/home.widget.dart' show Home;
import 'features/matching/widgets/matching-list.widget.dart' show MatchingList;

final appRoutes = {
  AppRoute.home.toString(): (context) => Home(),
  AppRoute.logIn.toString(): (context) => LogInContainer(),
  AppRoute.afterAuth.toString(): (context) => AfterAuthContainer(),
  AppRoute.matchingList.toString(): (context) => MatchingList(),
};
