import 'package:core_data/api/response/chat_message_request.dart';
import 'package:core_data/api/response/chat_message_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'chat_message_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001")
abstract class ChatMessageClient {
  factory ChatMessageClient(Dio dio, {String baseUrl}) = _ChatMessageClient;

  @POST("/chat/completions")
  Future<ChatMessageResponse> postChatMessage({
    @Body() required ChatMessageRequest request,
  });
}
