import 'package:drift/drift.dart';

@DataClassName('ChatMessage')
class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get geoElementId => integer()();
  IntColumn get type => integer()(); // 0 = user, 1 = AI
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
