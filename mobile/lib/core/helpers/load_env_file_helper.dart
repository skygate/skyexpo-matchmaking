import 'package:flutter_dotenv/flutter_dotenv.dart';

loadEnvFile() {
  return DotEnv().load();
}
