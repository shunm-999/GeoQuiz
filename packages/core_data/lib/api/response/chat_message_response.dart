import 'package:core_data/api/model/chat_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatMessageResponse {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "object")
  final String object;
  @JsonKey(name: "created")
  final int created;
  @JsonKey(name: "choices")
  final List<Choices> choices;
  @JsonKey(name: "usage")
  final Usage usage;

  ChatMessageResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Choices {
  @JsonKey(name: "index")
  final int index;
  @JsonKey(name: "message")
  final ChatMessage message;
  @JsonKey(name: "finish_reason")
  final String finishReason;

  Choices({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory Choices.fromJson(Map<String, dynamic> json) =>
      _$ChoicesFromJson(json);

  Map<String, dynamic> toJson() => _$ChoicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Usage {
  @JsonKey(name: "prompt_tokens")
  final int promptTokens;
  @JsonKey(name: "completion_tokens")
  final int completionTokens;
  @JsonKey(name: "total_tokens")
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
