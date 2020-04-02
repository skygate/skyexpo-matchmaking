import 'package:mobile/features/profile_form/models/team_model.dart';

const List<String> teamAvatarsUrlMock = [
  'https://i.pravatar.cc/150?img=57',
  'https://i.pravatar.cc/150?img=20',
  'https://i.pravatar.cc/150?img=27',
  'https://i.pravatar.cc/150?img=41'
];

final teamMock = Team(
    name: 'Arcology AI',
    logoUrl: 'https://logo.clearbit.com/testbook.com',
    membersAvatars: teamAvatarsUrlMock);
