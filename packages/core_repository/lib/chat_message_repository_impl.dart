import 'dart:async';

import 'package:core_data/api/client/chat_message_client.dart';
import 'package:core_data/api/model/chat_message.dart' as api_chat_message;
import 'package:core_data/api/response/chat_message_request.dart';
import 'package:core_data/db/dao/chat_message_dao.dart';
import 'package:core_data/db/geo_quiz_database.dart' as db;
import 'package:core_model/chat_message.dart';
import 'package:core_model/result.dart';
import 'package:dio/dio.dart';

import 'chat_message_repository.dart';

class ChatMessageRepositoryImpl implements ChatMessageRepository {
  final ChatMessageClient _chatMessageClient;

  final ChatMessageDao _chatMessageDao;

  ChatMessageRepositoryImpl({
    required ChatMessageClient chatMessageClient,
    required ChatMessageDao chatMessageDao,
  })  : _chatMessageClient = chatMessageClient,
        _chatMessageDao = chatMessageDao;

  @override
  Future<void> sendUserMessage({
    required int geoElementId,
    required String message,
  }) async {
    final result = await _sendUserMessage(
      geoElementId: geoElementId,
      userMessage: message,
    );
    final userMessage = UserChatMessage(
      id: 1,
      geoElementId: geoElementId,
      text: message,
      createdAt: DateTime.now(),
    );
    final aiMessage = AiChatMessage(
      id: 1,
      geoElementId: geoElementId,
      text: result.when(
        success: (value) {
          return value;
        },
        failure: (error) {
          return "エラーが発生しました。";
        },
      ),
      createdAt: DateTime.now(),
    );

    _chatMessageDao.insertChatMessage(
      db.ChatMessagesCompanion.insert(
        geoElementId: userMessage.geoElementId,
        type: 0,
        message: userMessage.text,
        createdAt: userMessage.createdAt,
        updatedAt: userMessage.createdAt,
      ),
    );

    _chatMessageDao.insertChatMessage(
      db.ChatMessagesCompanion.insert(
        geoElementId: aiMessage.geoElementId,
        type: 1,
        message: aiMessage.text,
        createdAt: aiMessage.createdAt,
        updatedAt: aiMessage.createdAt,
      ),
    );
  }

  Future<Result<String>> _sendUserMessage({
    required int geoElementId,
    required String userMessage,
  }) async {
    return await _chatMessageClient
        .postChatMessage(
            request: ChatMessageRequest(
      model: "gpt-4",
      messages: [
        api_chat_message.ChatMessage(
          role: "user",
          content: userMessage,
        )
      ],
    ))
        .then((response) {
      return Result.success(response.choices[0].message.content);
    }).catchError((error) {
      if (error is DioError) {
        return Result<String>.failure(Exception(error.toString()));
      } else {
        return Result<String>.failure(error);
      }
    });
  }

  @override
  Stream<Result<List<ChatMessage>>> fetchChatMessages({
    required int getElementId,
  }) {
    return _chatMessageDao.watchAllChatMessages().map((chatMessageEntityList) {
      final chatMessageList = chatMessageEntityList.map((chatMessageEntity) {
        if (chatMessageEntity.type == 0) {
          return UserChatMessage(
            id: chatMessageEntity.id,
            geoElementId: chatMessageEntity.geoElementId,
            text: chatMessageEntity.message,
            createdAt: chatMessageEntity.createdAt,
          );
        } else {
          return AiChatMessage(
            id: chatMessageEntity.id,
            geoElementId: chatMessageEntity.geoElementId,
            text: chatMessageEntity.message,
            createdAt: chatMessageEntity.createdAt,
          );
        }
      }).toList();
      return Result.success(chatMessageList);
    });
  }
}
