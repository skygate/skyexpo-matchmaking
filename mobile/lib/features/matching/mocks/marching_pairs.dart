import 'package:mobile/features/matching/models/matching_pair_model.dart';

final matchingList = [
  {
    "id": 1,
    "name": "Edwart Willson",
    "tags": "Investor | Fastcompany ",
    "percent": 98,
    "avatar": "https://i.pravatar.cc/150?img=57",
  },
  {
    "id": 2,
    "name": "Ellen Fernandes",
    "tags": "Investor | New Tech Lab ",
    "percent": 95,
    "avatar": "https://i.pravatar.cc/150?img=20",
  },
  {
    "id": 3,
    "name": "Edwart Willson",
    "tags": "Investor | Fastcompany ",
    "percent": 81,
    "avatar": "https://i.pravatar.cc/150?img=27",
  },
  {
    "id": 4,
    "name": "Edwart Willson",
    "tags": "Investor | Fastcompany ",
    "percent": 75,
    "avatar": "https://i.pravatar.cc/150?img=41",
  },
  {
    "id": 5,
    "name": "Edwart Willson",
    "tags": "Executive | inEnergy ",
    "percent": 74,
    "avatar": "https://i.pravatar.cc/150?img=28",
  },
  {
    "id": 6,
    "name": "Edwart Willson",
    "tags": "Executive | inEnergy ",
    "percent": 20,
    "avatar": "https://i.pravatar.cc/150?img=28",
  }
];

final List<MatchingPair> matchingListItems = matchingList
    .map((pair) => MatchingPair(
        id: pair['id'],
        name: pair['name'],
        tags: pair['tags'],
        percent: pair['percent'],
        avatarUrl: pair['avatar']))
    .toList();
