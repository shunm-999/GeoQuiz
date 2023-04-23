mixin ChatMessage {
  int get id;
  String get text;
  DateTime get createdAt;
}

class UserChatMessage implements ChatMessage {
  @override
  final int id;
  @override
  final String text;
  @override
  final DateTime createdAt;

  const UserChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createdAt.hashCode;
}

class AiChatMessage implements ChatMessage {
  @override
  final int id;
  @override
  final String text;
  @override
  final DateTime createdAt;

  const AiChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createdAt.hashCode;
}
