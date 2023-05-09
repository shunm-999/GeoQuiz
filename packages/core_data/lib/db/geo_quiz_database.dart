import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'entity/chat_messages.dart';

part 'geo_quiz_database.g.dart';

@DriftDatabase(
  tables: [
    ChatMessages,
  ],
)
class GeoQuizDatabase extends _$GeoQuizDatabase {
  GeoQuizDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'geo_quiz.db'));
    return NativeDatabase.createInBackground(file);
  });
}
