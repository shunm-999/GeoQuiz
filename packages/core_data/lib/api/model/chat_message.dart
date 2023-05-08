import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatMessage {
  @JsonKey(name: "role")
  final String role;
  @JsonKey(name: "content")
  final String content;

  ChatMessage({
    required this.role,
    required this.content,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
