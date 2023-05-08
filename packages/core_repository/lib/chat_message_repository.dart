import 'package:core_model/chat_message.dart';
import 'package:core_model/result.dart';

abstract class ChatMessageRepository {
  Future<void> sendUserMessage({
    required int geoElementId,
    required String message,
  });

  Stream<Result<List<ChatMessage>>> fetchChatMessages({
    required int getElementId,
  });
}
