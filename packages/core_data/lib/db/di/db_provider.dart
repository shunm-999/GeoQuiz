import 'package:core_data/db/dao/chat_message_dao.dart';
import 'package:core_data/db/geo_quiz_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _databaseProvider = Provider<GeoQuizDatabase>((ref) {
  return GeoQuizDatabase();
});

final chatMessageDaoProvider = Provider((ref) {
  final database = ref.watch(_databaseProvider);
  return ChatMessageDao(database);
});
