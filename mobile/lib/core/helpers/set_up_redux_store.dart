import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:mobile/config/env_variables_config.dart' as env;
import 'package:mobile/features/auth/reducers/auth_reducer.dart';
import 'package:mobile/store/app_state.dart';
import 'package:mobile/store/root_epic.dart';

Future<Store<AppState>> setUpReduxStore() async {
  final remoteDevtools =
      RemoteDevToolsMiddleware(env.emulatorHost + ':' + env.reduDevtoolsPort);
  await remoteDevtools.connect();

  final store = DevToolsStore<AppState>(appReducer,
      initialState: AppState(auth: AuthState()),
      middleware: [remoteDevtools, epicMiddleware]);

  remoteDevtools.store = store;

  return store;
}
