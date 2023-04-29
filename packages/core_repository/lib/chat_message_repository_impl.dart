import 'dart:async';

import 'package:core_model/chat_message.dart';
import 'package:core_model/result.dart';

import 'chat_message_repository.dart';

class ChatMessageRepositoryImpl implements ChatMessageRepository {
  final _chatMessageStreamController =
      StreamController<Map<int, List<ChatMessage>>>.broadcast();

  final Map<int, List<ChatMessage>> _chatMessages =
      <int, List<ChatMessage>>{}; // TODO 仮実装

  ChatMessageRepositoryImpl();

  @override
  void addUserMessage({
    required int geoElementId,
    required String message,
  }) {
    final messageList = [
      UserChatMessage(
        id: 1,
        geoElementId: geoElementId,
        text: message,
        createdAt: DateTime.now(),
      ),
      AiChatMessage(
        id: 1,
        geoElementId: geoElementId,
        text: message,
        createdAt: DateTime.now(),
      ),
    ];
    _chatMessages.update(
      geoElementId,
      (value) => [...value, ...messageList],
      ifAbsent: () => messageList,
    );
    _chatMessageStreamController.add(_chatMessages);
  }

  @override
  Stream<Result<List<ChatMessage>>> fetchChatMessages({
    required int getElementId,
  }) {
    return _chatMessageStreamController.stream.map((event) {
      return Result.success(event[getElementId] ?? List.empty());
    });
  }
}
