import 'package:core_data/db/entity/chat_messages.dart';
import 'package:core_data/db/geo_quiz_database.dart';
import 'package:drift/drift.dart';

part 'chat_message_dao.g.dart';

@DriftAccessor(tables: [ChatMessages])
class ChatMessageDao extends DatabaseAccessor<GeoQuizDatabase>
    with _$ChatMessageDaoMixin {
  ChatMessageDao(GeoQuizDatabase db) : super(db);

  Future<List<ChatMessage>> getAllChatMessages() => select(chatMessages).get();

  Stream<List<ChatMessage>> watchAllChatMessages() =>
      select(chatMessages).watch();

  Future insertChatMessage(ChatMessagesCompanion chatMessage) =>
      into(chatMessages).insert(chatMessage);

  Future updateChatMessage(ChatMessagesCompanion chatMessage) =>
      update(chatMessages).replace(chatMessage);

  Future deleteChatMessage(ChatMessagesCompanion chatMessage) =>
      delete(chatMessages).delete(chatMessage);
}
