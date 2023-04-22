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

part 'drift_database.g.dart';  // error for now



@DriftDatabase(
  tables: [
    Goals,  // modify
    Moods,  // modify
    Todos,  // modify
  ],
)

class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;  // manage schema version
}

// set DB location
LazyDatabase _openConnection(){
  return LazyDatabase(()async{
    final dbFolder = await getApplicationDocumentsDirectory();  // bring application directory assigned by OS
    final file = File(p.join(dbFolder.path, 'db.sqlite'));  // Import library 'dart.io'. // set file name as db.sqlite
    return NativeDatabase(file);
  });
}