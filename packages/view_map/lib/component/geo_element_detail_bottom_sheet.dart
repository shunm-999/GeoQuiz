import 'package:core_model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_map/viewmodel/chat_message_viewmodel.dart';

void showMapPinModelBottomSheet({
  required BuildContext context,
  required int geoElementId,
  required String geoElementName,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return GeoElementDetailBottomSheet(
        geoElementId: geoElementId,
        geoElementName: geoElementName,
      );
    },
  );
}

class GeoElementDetailBottomSheet extends StatefulHookConsumerWidget {
  final int geoElementId;
  final String geoElementName;

  const GeoElementDetailBottomSheet({
    super.key,
    required this.geoElementId,
    required this.geoElementName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GeoElementDetailBottomSheetState();
}

class _GeoElementDetailBottomSheetState
    extends ConsumerState<GeoElementDetailBottomSheet> {
  _GeoElementDetailBottomSheetState();

  late final viewModel = ref.read(chatMessageViewModelProvider.notifier);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.fetchChatMessage(geoElementId: widget.geoElementId);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void _onChange(String value) {
    setState(() {});
  }

  void _onSubmitted(String value) {
    viewModel.addChatMessage(
      geoElementId: widget.geoElementId,
      message: value,
    );
    _textEditingController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    final uiState = ref.watch(chatMessageViewModelProvider);

    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _ChatMessageScreen(
                  chatMessageList: uiState.chatMessageList,
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessageScreen extends StatefulWidget {
  final List<ChatMessage> chatMessageList;

  const _ChatMessageScreen({required this.chatMessageList});

  @override
  State<StatefulWidget> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<_ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
        ),
        child: Column(
          children: [
            for (final chatMessage in widget.chatMessageList)
              Align(
                alignment: chatMessage is UserChatMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ChatCard(
                    borderColor: chatMessage is UserChatMessage
                        ? Colors.lightBlueAccent
                        : Colors.grey,
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
              ),
          ],
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final String chatMessage;
  final Color borderColor;
  final BorderRadius borderRadius;

  const ChatCard({
    super.key,
    required this.chatMessage,
    required this.borderColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.6,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
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
