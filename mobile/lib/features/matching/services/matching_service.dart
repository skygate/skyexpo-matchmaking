import 'package:mobile/core/services/http_service.dart' show HttpService;

import 'package:mobile/features/matching/models/matching_pair_model.dart';
import '../mocks/marching_pairs.dart';

class MatchingService {
  final HttpService http;

  MatchingService(this.http);

  Future<List<MatchingPair>> getMatchingParis({int userId}) async {
    return matchingListItems; // return mocked data
  }
}
