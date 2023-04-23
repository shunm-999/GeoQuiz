import 'package:core_model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showMapPinModelBottomSheet({
  required BuildContext context,
  required String geoElementName,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return GeoElementDetailBottomSheet(
        geoElementName: geoElementName,
      );
    },
  );
}

class GeoElementDetailBottomSheet extends StatefulHookConsumerWidget {
  final String geoElementName;

  const GeoElementDetailBottomSheet({super.key, required this.geoElementName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GeoElementDetailBottomSheetState();
}

class _GeoElementDetailBottomSheetState
    extends ConsumerState<GeoElementDetailBottomSheet> {
  _GeoElementDetailBottomSheetState();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void _onChange(String value) {
    setState(() {});
  }

  void _onSubmitted(String value) {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: bottomPadding,
      ),
      child: Container(
        height: screenHeight * 0.6,
        child: Column(
          children: [
            Text(
              widget.geoElementName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const _ChatMessageScreen(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: true,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Enter a your word",
                    ),
                    onChanged: _onChange,
                    onSubmitted: _onSubmitted,
                  ),
                ),
                IconButton(
                  onPressed: _buttonCallback(
                    _textEditingController.text.isNotEmpty,
                    () {
                      _onSubmitted(_textEditingController.text);
                    },
                  ),
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessageScreen extends StatelessWidget {
  const _ChatMessageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> chatMessages = List.of([
      UserChatMessage(
        id: 1,
        text: "Hello, how about you?",
        createdAt: DateTime.now(),
      ),
      AiChatMessage(
        id: 2,
        text: "I'm fine, thank you.",
        createdAt: DateTime.now(),
      ),
      UserChatMessage(
        id: 3,
        text: "I'm fine, thank you.",
        createdAt: DateTime.now(),
      ),
      AiChatMessage(
        id: 4,
        text: "I'm fine, thank you.",
        createdAt: DateTime.now(),
      ),
      UserChatMessage(
        id: 5,
        text: "I'm fine, thank you.",
        createdAt: DateTime.now(),
      ),
      AiChatMessage(
        id: 6,
        text: "I'm fine, thank you.",
        createdAt: DateTime.now(),
      ),
    ]);

    const borderRadius = 8.0;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: Column(
            children: [
              for (final chatMessage in chatMessages)
                Align(
                  alignment: chatMessage is UserChatMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ChatCard(
                    color: chatMessage is UserChatMessage
                        ? Colors.blue
                        : Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: chatMessage is UserChatMessage
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                      topRight: chatMessage is UserChatMessage
                          ? Radius.zero
                          : const Radius.circular(borderRadius),
                      bottomLeft: const Radius.circular(borderRadius),
                      bottomRight: const Radius.circular(borderRadius),
                    ),
                    chatMessage: chatMessage.text,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final String chatMessage;
  final Color color;
  final BorderRadius borderRadius;

  const ChatCard({
    super.key,
    required this.chatMessage,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(chatMessage),
        ),
      ),
    );
  }
}

VoidCallback? _buttonCallback(bool enabled, VoidCallback? callback) {
  if (enabled) {
    return callback;
  } else {
    return null;
  }
}
