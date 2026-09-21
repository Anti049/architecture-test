import '../entities/work.dart';

abstract interface class WorkRepository {
  Future<List<Work>> getLibrary();
  Future<Work?> getWork(String id);
  Stream<List<Work>> watchLibrary();
  Future<void> upsert(Work work);
  Future<void> markChapterRead(String chapterId, {required bool read});
}

abstract interface class HistoryRepository {
  Future<List<Work>> recentlyRead();
}

abstract interface class UpdatesRepository {
  Future<List<Chapter>> recentUpdates();
}
