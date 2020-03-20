import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:mobile/config/env_variables_config.dart' as env;
import 'package:mobile/features/auth/reducers/auth.reducer.dart';
import 'package:mobile/store/app-state.dart';
import 'package:mobile/store/root-epic.dart';

Future<Store<AppState>> setUpReduxStore() async {
  final remoteDevtools =
      RemoteDevToolsMiddleware(env.emulatorHost + ':' + env.backendPort);
  await remoteDevtools.connect();

  final store = new DevToolsStore<AppState>(appReducer,
      initialState: new AppState(auth: new AuthState()),
      middleware: [remoteDevtools, epicMiddleware]);

  remoteDevtools.store = store;

  return store;
}
