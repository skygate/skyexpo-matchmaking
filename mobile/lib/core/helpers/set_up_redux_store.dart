import 'package:redux/redux.dart' show Store;
import 'package:redux_remote_devtools/redux_remote_devtools.dart'
    show RemoteDevToolsMiddleware;
import 'package:redux_dev_tools/redux_dev_tools.dart' show DevToolsStore;

import 'package:mobile/config/env_variables_config.dart' as env;
import 'package:mobile/store/app_state.dart'
    show AppState, initState, appReducer;
import 'package:mobile/store/root_epic.dart' show epicMiddleware;

Future<Store<AppState>> setUpReduxStore() async {
  final remoteDevtools =
      RemoteDevToolsMiddleware(env.emulatorHost + ':' + env.reduxDevtoolsPort);
  await remoteDevtools.connect();

  final store = DevToolsStore<AppState>(appReducer,
      initialState: initState, middleware: [remoteDevtools, epicMiddleware]);

  remoteDevtools.store = store;

  return store;
}
