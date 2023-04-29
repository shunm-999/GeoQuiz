mixin ChatMessage {
  int get id;
  int get geoElementId;
  String get text;
  DateTime get createdAt;
}

class UserChatMessage implements ChatMessage {
  @override
  final int id;
  @override
  final int geoElementId;
  @override
  final String text;
  @override
  final DateTime createdAt;

  const UserChatMessage({
    required this.id,
    required this.geoElementId,
    required this.text,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          geoElementId == other.geoElementId &&
          text == other.text &&
          createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createdAt.hashCode;
}

class AiChatMessage implements ChatMessage {
  @override
  final int id;
  @override
  final int geoElementId;
  @override
  final String text;
  @override
  final DateTime createdAt;

  const AiChatMessage({
    required this.id,
    required this.geoElementId,
    required this.text,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          geoElementId == other.geoElementId &&
          text == other.text &&
          createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createdAt.hashCode;
}
