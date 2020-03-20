import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/config/colors.config.dart';
import 'package:mobile/core/helpers/set_up_network_debugger_helper.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:mobile/config/routes.config.dart';
import 'package:mobile/store/app-state.dart';
import 'package:mobile/store/root-epic.dart';

import 'features/auth/reducers/auth.reducer.dart';

import 'features/auth/containers/after-auth.container.dart';
import 'features/auth/containers/log-in.container.dart';
import 'features/auth/widgets/home.widget.dart';
import 'features/matching/widgets/matching-list.widget.dart';

void main() async {
  var remoteDevtools = RemoteDevToolsMiddleware(
      '192.168.0.109:8000'); // I will add env in next pr
  await remoteDevtools.connect();

  WidgetsFlutterBinding.ensureInitialized();
  final store = new DevToolsStore<AppState>(appReducer,
      initialState: new AppState(auth: new AuthState()),
      middleware: [remoteDevtools, epicMiddleware]);

  remoteDevtools.store = store;

  setUpNetworkDebugger();

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
