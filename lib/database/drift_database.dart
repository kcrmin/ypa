// database/drift_database.dart
// drift main layout
import 'dart:io';

// DB location package
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// models modify
import '../model/goal.dart';
import '../model/mood.dart';
import '../model/todo_item.dart';
import 'package:ypa/model/mood_color.dart';

part 'drift_database.g.dart';  // error for now



@DriftDatabase(
  tables: [
    Goals,  // modify
    Moods,  // modify
    Todos,  // modify
    MoodColors,
  ],
)

class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;  // manage schema version

  /// create
  Future<int> createGoal(GoalsCompanion data) =>
      into(goals).insert(data);  // Model/Table/Class in lowercase on first letter

  Future<int> createMood(MoodsCompanion data) =>
      into(moods).insert(data);  // Model/Table/Class in lowercase on first letter

  Future<int> createTodo(TodosCompanion data) =>
      into(todos).insert(data);  // Model/Table/Class in lowercase on first letter

  Future<int> createColor(MoodColorsCompanion data) =>
      into(moodColors).insert(data);

  /// select
  Future<List<Mood>> getMoods() =>
      select(moods).get();

  Future<List<Goal>> getGoals() =>
      select(goals).get();

  Future<List<Todo>> getTodos() =>
      select(todos).get();

  Future<List<MoodColor>> getColors() =>
      select(moodColors).get();
}

// set DB location
LazyDatabase _openConnection(){
  return LazyDatabase(()async{
    final dbFolder = await getApplicationDocumentsDirectory();  // bring application directory assigned by OS
    final file = File(p.join(dbFolder.path, 'db.sqlite'));  // Import library 'dart.io'. // set file name as db.sqlite
    return NativeDatabase(file);
  });
}