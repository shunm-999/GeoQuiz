import 'package:core_model/chat_message.dart';
import 'package:core_repository/chat_message_repository.dart';
import 'package:core_repository/di/repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatMessageViewModelProvider =
    StateNotifierProvider.autoDispose<ChatMessageViewModel, ChatMessageUiState>(
  (ref) {
    final chatMessageRepository = ref.watch(chatMessageRepositoryProvider);
    return ChatMessageViewModel(chatMessageRepository: chatMessageRepository);
  },
);

@immutable
class ChatMessageUiState {
  final List<ChatMessage> chatMessageList;

  const ChatMessageUiState({
    required this.chatMessageList,
  });

  ChatMessageUiState copyWith({
    List<ChatMessage>? chatMessageList,
  }) {
    return ChatMessageUiState(
      chatMessageList: chatMessageList ?? this.chatMessageList,
    );
  }
}

class ChatMessageViewModel extends StateNotifier<ChatMessageUiState> {
  final ChatMessageRepository _chatMessageRepository;

  ChatMessageViewModel({required ChatMessageRepository chatMessageRepository})
      : _chatMessageRepository = chatMessageRepository,
        super(
          ChatMessageUiState(
            chatMessageList: List.empty(),
          ),
        );

  void addChatMessage({
    required int geoElementId,
    required String message,
  }) {
    _chatMessageRepository.addUserMessage(
      geoElementId: geoElementId,
      message: message,
    );
  }

  void fetchChatMessage({
    required int geoElementId,
  }) {
    _chatMessageRepository
        .fetchChatMessages(
      getElementId: geoElementId,
    )
        .listen((result) {
      result.when(
        success: (chatMessages) {
          state = state.copyWith(
            chatMessageList: chatMessages,
          );
        },
        failure: (error) {},
      );
    });
  }
}
