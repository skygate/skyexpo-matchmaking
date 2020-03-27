import 'package:mobile/features/auth/models/index.dart'
    show Credentials, RegisterRequest, User;

final userMock =
    User(id: "SDF", email: "test@email", name: "username", token: "token");

final credentailsMock =
    Credentials(email: 'test@email.com', password: 'sdfjl;3hkjSDF');

final registerRequestMock = RegisterRequest(
    name: 'Arecek', email: 'test@email.com', password: 'sdfjl;3hkjSDF');

const userResponseMock =
    '{"id":"SDF","email":"test@email","name":"username","token":"token"}';
