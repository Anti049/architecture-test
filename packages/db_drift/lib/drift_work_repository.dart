import 'package:core_domain/core_domain.dart' as domain;
import 'package:drift/drift.dart';
import 'database.dart';

class DriftWorkRepository implements domain.WorkRepository {
  final AppDatabase db;
  DriftWorkRepository(this.db);

  @override
  Future<List<domain.Work>> getLibrary() async {
    final rows = await db.select(db.works).get();
    return rows
        .map((r) => domain.Work(
              id: r.id,
              title: r.title,
              author: r.author,
              coverUrl: r.coverUrl,
              description: r.description,
            ),)
        .toList();
  }

  @override
  Future<domain.Work?> getWork(String id) async {
    final row = await (db.select(db.works)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return domain.Work(
      id: row.id,
      title: row.title,
      author: row.author,
      coverUrl: row.coverUrl,
      description: row.description,
    );
  }

  @override
  Stream<List<domain.Work>> watchLibrary() => db.select(db.works).watch().map(
        (rows) => rows
            .map((r) => domain.Work(
                  id: r.id,
                  title: r.title,
                  author: r.author,
                  coverUrl: r.coverUrl,
                  description: r.description,
                ),)
            .toList(),
      );

  @override
  Future<void> upsert(domain.Work work) async {
    await db.into(db.works).insertOnConflictUpdate(
          WorksCompanion.insert(
            id: work.id,
            title: work.title,
            author: work.author,
            coverUrl: Value(work.coverUrl),
            description: Value(work.description),
          ),
        );
  }

  @override
  Future<void> markChapterRead(String chapterId, {required bool read}) async {
    // Chapters table omitted for brevity in this comparison scaffold.
  }
}
