import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:mobile/config/routes.config.dart' show routes, navigatorKey;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/config/colors.config.dart';
import 'package:mobile/core/helpers/load_env_file_helper.dart' show loadEnvFile;
import 'package:mobile/core/helpers/set_up_network_debugger_helper.dart'
    show setUpNetworkDebugger;
import 'package:mobile/core/helpers/set_up_redux_store.dart'
    show setUpReduxStore;

import 'features/auth/containers/after-auth.container.dart'
    show AfterAuthContainer;
import 'features/auth/containers/log-in.container.dart' show LogInContainer;
import 'features/auth/widgets/home.widget.dart' show Home;
import 'features/matching/widgets/matching-list.widget.dart' show MatchingList;

Future main() async {
  await loadEnvFile();
  setUpNetworkDebugger();
  final store = await setUpReduxStore();

  runApp(Main(store: store));
}

class Main extends StatelessWidget {
  final Store<AppState> store;

  Main({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Sky expo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                backgroundColor: colors["background"]),
            initialRoute: routes['home'],
            navigatorKey: navigatorKey,
            routes: {
              routes['home']: (context) => Home(),
              routes['logIn']: (context) => LogInContainer(),
              routes['afterAuth']: (context) => AfterAuthContainer(),
              routes['matchingList']: (context) => MatchingList(),
            }));
  }
}
