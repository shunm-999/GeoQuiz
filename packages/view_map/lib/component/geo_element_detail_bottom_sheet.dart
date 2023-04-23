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

  void _onChange(String value) {}

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
            Text(widget.geoElementName),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Text("test"),
                ),
              ),
            ),
            TextField(
              enabled: true,
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: "Enter a your word",
              ),
              onChanged: _onChange,
              onSubmitted: _onSubmitted,
            ),
          ],
        ),
      ),
    );
  }
}
