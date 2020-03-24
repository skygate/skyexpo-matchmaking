import 'package:reselect/reselect.dart' show createSelector1;

import 'package:mobile/store/app_state.dart' show AppState;

final getAuthStateSelector = (AppState state) => state.auth;

final getUserEmailSelector =
    createSelector1(getAuthStateSelector, (authState) => authState.email);
