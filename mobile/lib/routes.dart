import 'config/routes_config.dart' show Route;
import 'features/auth/containers/after-auth.container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log-in.container.dart' show LogInContainer;
import 'features/auth/widgets/home.widget.dart' show Home;
import 'features/matching/widgets/matching-list.widget.dart' show MatchingList;

final appRoutes = {
  Route.home.toString(): (context) => Home(),
  Route.logIn.toString(): (context) => LogInContainer(),
  Route.afterAuth.toString(): (context) => AfterAuthContainer(),
  Route.matchingList.toString(): (context) => MatchingList(),
};
