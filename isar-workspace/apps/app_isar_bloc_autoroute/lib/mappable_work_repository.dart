import 'dart:async';

import 'package:core_domain/core_domain.dart';
import 'work_dto.dart';

class MappableWorkRepository implements WorkRepository {
  final WorkRepository _inner;
  const MappableWorkRepository(this._inner);

  Work _roundTrip(Work work) =>
      WorkDtoMapper.fromJson(WorkDto.fromDomain(work).toJson()).toDomain();

  @override
  Future<List<Work>> getLibrary() async =>
      (await _inner.getLibrary()).map(_roundTrip).toList();

  @override
  Future<Work?> getWork(String id) async {
    final work = await _inner.getWork(id);
    return work == null ? null : _roundTrip(work);
  }

  @override
  Stream<List<Work>> watchLibrary() =>
      _inner.watchLibrary().map((works) => works.map(_roundTrip).toList());

  @override
  Future<void> upsert(Work work) async {
    await _inner.upsert(_roundTrip(work));
  }

  @override
  Future<void> markChapterRead(String chapterId, {required bool read}) =>
      _inner.markChapterRead(chapterId, read: read);
}
