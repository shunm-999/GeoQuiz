import 'dart:async';

import 'package:core_data/api/client/chat_message_client.dart';
import 'package:core_data/api/model/chat_message.dart' as api_chat_message;
import 'package:core_data/api/response/chat_message_request.dart';
import 'package:core_model/chat_message.dart';
import 'package:core_model/result.dart';
import 'package:dio/dio.dart';

import 'chat_message_repository.dart';

class ChatMessageRepositoryImpl implements ChatMessageRepository {
  final _chatMessageStreamController =
      StreamController<Map<int, List<ChatMessage>>>.broadcast();

  final Map<int, List<ChatMessage>> _chatMessages =
      <int, List<ChatMessage>>{}; // TODO 仮実装

  final ChatMessageClient _chatMessageClient;

  ChatMessageRepositoryImpl({
    required ChatMessageClient chatMessageClient,
  }) : _chatMessageClient = chatMessageClient;

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

    _chatMessages.update(
      geoElementId,
      (value) => [
        ...value,
        ...[userMessage, aiMessage]
      ],
      ifAbsent: () => [userMessage, aiMessage],
    );
    _chatMessageStreamController.add(_chatMessages);
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
    return _chatMessageStreamController.stream.map((event) {
      return Result.success(event[getElementId] ?? List.empty());
    });
  }
}
