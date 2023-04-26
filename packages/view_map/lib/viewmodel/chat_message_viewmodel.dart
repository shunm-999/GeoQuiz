import 'package:core_model/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatMessageViewModelProvider =
    StateNotifierProvider.autoDispose<ChatMessageViewModel, ChatMessageUiState>(
  (ref) {
    return ChatMessageViewModel();
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
  ChatMessageViewModel()
      : super(
          ChatMessageUiState(
            chatMessageList: List.empty(),
          ),
        );

  void addChatMessage({required String message}) {
    // TODO 仮実装
    state = state.copyWith(
      chatMessageList: [
        ...state.chatMessageList,
        UserChatMessage(
          id: 1,
          text: message,
          createdAt: DateTime.now(),
        ),
        AiChatMessage(
          id: 2,
          text: message,
          createdAt: DateTime.now(),
        )
      ],
    );
  }
}
