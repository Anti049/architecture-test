import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Works extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get coverUrl => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Works])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'architecture_test'));
  @override
  int get schemaVersion => 1;
}
