import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:mobile/config/routes_config.dart' as routes;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/config/colors.config.dart';
import 'package:mobile/core/helpers/load_env_file_helper.dart' show loadEnvFile;
import 'package:mobile/core/helpers/set_up_network_debugger_helper.dart'
    show setUpNetworkDebugger;
import 'package:mobile/core/helpers/set_up_redux_store.dart'
    show setUpReduxStore;

import 'routes.dart' show appRoutes;

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
            initialRoute: routes.Route.home.toString(),
            navigatorKey: routes.navigatorKey,
            routes: appRoutes));
  }
}
