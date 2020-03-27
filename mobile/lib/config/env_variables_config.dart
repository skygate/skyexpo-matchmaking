import 'package:flutter_dotenv/flutter_dotenv.dart';

getEnv(name) => DotEnv().env[name];

final emulatorHost = getEnv('EMULATOR_HOST');
final backendPort = getEnv('BACKEND_PORT');
final reduxDevtoolsPort = getEnv('REDUX_DEVTOOLS_PORT');
