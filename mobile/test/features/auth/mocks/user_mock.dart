import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;
import 'package:mobile/features/auth/models/user_model.dart' show User;

final userMock =
    User(id: "SDF", email: "test@email", name: "username", token: "token");

final credentailsMock =
    Credentials(email: 'test@email.com', password: 'sdfjl;3hkjSDF');

const userResponseMock =
    '{"id":"SDF","email":"test@email","name":"username","token":"token"}';
