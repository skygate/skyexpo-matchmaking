import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/config/routes.config.dart';
import 'package:mobile/features/auth/widgets/after-auth.widget.dart';
import 'package:redux/redux.dart';

import 'package:mobile/store/app-state.dart';
import 'package:mobile/store/root-epic.dart';
import 'features/auth/reducers/auth.reducer.dart';
import 'features/auth/widgets/home.widget.dart';
import 'features/auth/containers/log-in.container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Main());
}

class Main extends StatelessWidget {
  final Store<AppState> store;

  Main({
    Key key,
  })  : store = Store<AppState>(appReducer,
            initialState: new AppState(auth: new AuthState()),
            middleware: [epicMiddleware]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Sky expo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: routes['home'],
            navigatorKey: navigatorKey,
            routes: {
              routes['home']: (context) => Home(),
              routes['logIn']: (context) => LogInContainer(),
              routes['afterAuth']: (context) => AfterAuth(),
            }));
  }
}
