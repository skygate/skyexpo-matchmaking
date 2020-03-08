import 'package:mobile/features/auth/models/credentails.model.dart';
import 'package:mobile/features/auth/models/user.model.dart';

class LogInRequestAction {
  final Credentials credentials;

  LogInRequestAction(this.credentials);

  @override
  String toString() {
    return 'LogInRequestAction{credentials: $credentials}';
  }
}

class LogInSucceedAction {
  final User user;

  LogInSucceedAction(this.user);

  @override
  String toString() {
    return 'LogInSucceedAction{userData: $user}';
  }
}

class LogInFailedAction {}
