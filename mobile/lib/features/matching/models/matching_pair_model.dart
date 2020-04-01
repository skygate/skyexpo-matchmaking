import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'matching_pair_model.g.dart';

@JsonSerializable()
class MatchingPair {
  int id;
  String name;
  String tags;
  int percent;
  String avatarUrl;

  MatchingPair({this.id, this.name, this.tags, this.percent, this.avatarUrl});

  factory MatchingPair.fromJson(Map<String, dynamic> json) =>
      _$MatchingPairFromJson(json);
  Map<String, dynamic> toJson() => _$MatchingPairToJson(this);
}
