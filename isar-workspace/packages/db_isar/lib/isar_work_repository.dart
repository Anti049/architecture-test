import 'package:core_domain/core_domain.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'work_collection.dart';

class IsarWorkRepository implements WorkRepository {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([WorkModelSchema], directory: dir.path);
  }

  Work _toDomain(WorkModel r) => Work(
        id: r.uid,
        title: r.title,
        author: r.author,
        coverUrl: r.coverUrl,
        description: r.description,
      );

  @override
  Future<List<Work>> getLibrary() async {
    final rows = await isar.workModels.where().findAll();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<Work?> getWork(String id) async {
    final r = await isar.workModels.filter().uidEqualTo(id).findFirst();
    return r == null ? null : _toDomain(r);
  }

  @override
  Stream<List<Work>> watchLibrary() =>
      isar.workModels.where().watch(fireImmediately: true).map(
            (rows) => rows.map(_toDomain).toList(),
          );

  @override
  Future<void> upsert(Work work) async {
    await isar.writeTxn(() async {
      final model = WorkModel()
        ..uid = work.id
        ..title = work.title
        ..author = work.author
        ..coverUrl = work.coverUrl
        ..description = work.description;
      await isar.workModels.put(model);
    });
  }

  @override
  Future<void> markChapterRead(String chapterId, {required bool read}) async {}
}
