import 'package:core_data/api/client/overpass_client.dart';
import 'package:core_data/api/secret_key.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../client/chat_message_client.dart';

final _dioProvider = Provider<Dio>((ref) {
  return Dio()..interceptors.add(LogInterceptor());
});

final overpassClientProvider = Provider<OverpassClient>((ref) {
  final dioProvider = ref.watch(_dioProvider);
  return OverpassClient(dioProvider);
});

final chatMessageClientProvider = Provider<ChatMessageClient>((ref) {
  final dioProvider = ref.watch(_dioProvider);
  return ChatMessageClient(dioProvider, baseUrl: OPENAI_API_HOST);
});
