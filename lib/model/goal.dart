import 'package:drift/drift.dart';

class Goals extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // Content
  TextColumn get title => text()();

  // DueDate
  DateTimeColumn get dueDate => dateTime()();

  // Progress
  IntColumn get completed => integer()();
}