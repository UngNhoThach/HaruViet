import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class CommentResponse {
  @JsonKey(name: 'Childs')
  List<CommentResponse>? childs;
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'PostId')
  String? postId;
  @JsonKey(name: 'Text')
  String? text;
  @JsonKey(name: 'Images')
  String? images;
  @JsonKey(name: 'ParentId')
  int? parentId;
  @JsonKey(name: 'React')
  int? react;
  @JsonKey(name: 'ReactIcons')
  String? reactIcons;
  @JsonKey(name: 'Liked')
  int? liked;
  @JsonKey(name: 'Relay')
  int? relay;
  @JsonKey(name: 'Status')
  int? status;
  @JsonKey(name: 'CreatedDate')
  String? createdDate;
  @JsonKey(name: 'CreatedBy')
  String? createdBy;
  @JsonKey(name: 'Avatar')
  String? avatar;
  @JsonKey(name: 'FullName')
  String? fullName;

  CommentResponse({
    this.childs,
    this.id,
    this.postId,
    this.text,
    this.images,
    this.parentId,
    this.react,
    this.reactIcons,
    this.liked,
    this.relay,
    this.status,
    this.createdDate,
    this.createdBy,
    this.avatar,
    this.fullName,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return _$CommentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
