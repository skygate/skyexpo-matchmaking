import 'package:flutter_dotenv/flutter_dotenv.dart';

loadEnvFile() async {
  await DotEnv().load('../backend/config/.env');
}
