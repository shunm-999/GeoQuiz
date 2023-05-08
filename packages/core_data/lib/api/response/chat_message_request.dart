import 'package:core_data/api/model/chat_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatMessageRequest {
  @JsonKey(name: "model")
  final String model;
  @JsonKey(name: "messages")
  final List<ChatMessage> messages;

  ChatMessageRequest({
    required this.model,
    required this.messages,
  });

  factory ChatMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageRequestToJson(this);
}
