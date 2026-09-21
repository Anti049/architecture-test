import 'package:core_domain/core_domain.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteWorkRepository implements WorkRepository {
  late final Database _db;

  Future<void> init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'architecture_test.db'),
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE works(
          id TEXT PRIMARY KEY,
          title TEXT,
          author TEXT,
          coverUrl TEXT,
          description TEXT)'''),
    );
  }

  Work _fromRow(Map<String, Object?> r) => Work(
        id: r['id'] as String,
        title: r['title'] as String,
        author: r['author'] as String,
        coverUrl: r['coverUrl'] as String? ?? '',
        description: r['description'] as String? ?? '',
      );

  @override
  Future<List<Work>> getLibrary() async {
    final rows = await _db.query('works');
    return rows.map(_fromRow).toList();
  }

  @override
  Future<Work?> getWork(String id) async {
    final rows = await _db.query('works', where: 'id = ?', whereArgs: [id]);
    return rows.isEmpty ? null : _fromRow(rows.first);
  }

  @override
  Stream<List<Work>> watchLibrary() async* {
    yield await getLibrary();
  }

  @override
  Future<void> upsert(Work work) async {
    await _db.insert(
      'works',
      {
        'id': work.id,
        'title': work.title,
        'author': work.author,
        'coverUrl': work.coverUrl,
        'description': work.description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> markChapterRead(String chapterId, {required bool read}) async {}
}
