import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart' show StoreProvider;
import 'package:redux/redux.dart' show Store;

import 'main.reflectable.dart' show initializeReflectable;
import 'package:mobile/config/routes_config.dart' show AppRoute, navigatorKey;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/core/helpers/load_env_file_helper.dart' show loadEnvFile;
import 'package:mobile/core/helpers/set_up_network_debugger_helper.dart'
    show setUpNetworkDebugger;
import 'package:mobile/core/helpers/set_up_redux_store.dart'
    show setUpReduxStore;
import 'routes.dart' show appRoutes;

Future main() async {
  initializeReflectable();
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
                backgroundColor: AppColor.primary.value),
            initialRoute: AppRoute.logIn.value,
            navigatorKey: navigatorKey,
            routes: appRoutes));
  }
}
