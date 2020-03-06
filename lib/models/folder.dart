import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class FolderModel {
  int id;
  String label;

  FolderModel({this.id, this.label = ''});

  static final FolderModel zero = FolderModel();

  factory FolderModel.fromJson(Map user) => _$FolderModelFromJson(user);

  Map<String, dynamic> toJson() => _$FolderModelToJson(this);
}
