import 'package:dart_mappable/dart_mappable.dart';
import 'package:core_domain/core_domain.dart';

part 'work_dto.mapper.dart';

@MappableClass()
class WorkDto with WorkDtoMappable {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final List<ChapterDto> chapters;

  const WorkDto({
    required this.id,
    required this.title,
    required this.author,
    this.coverUrl = '',
    this.description = '',
    this.chapters = const [],
  });

  factory WorkDto.fromDomain(Work work) => WorkDto(
        id: work.id,
        title: work.title,
        author: work.author,
        coverUrl: work.coverUrl,
        description: work.description,
        chapters: work.chapters.map(ChapterDto.fromDomain).toList(),
      );

  Work toDomain() => Work(
        id: id,
        title: title,
        author: author,
        coverUrl: coverUrl,
        description: description,
        chapters: chapters.map((chapter) => chapter.toDomain(workId: id)).toList(),
      );
}

@MappableClass()
class ChapterDto with ChapterDtoMappable {
  final String id;
  final int number;
  final String name;
  final bool read;

  const ChapterDto({
    required this.id,
    required this.number,
    required this.name,
    this.read = false,
  });

  factory ChapterDto.fromDomain(Chapter chapter) => ChapterDto(
        id: chapter.id,
        number: chapter.number,
        name: chapter.name,
        read: chapter.read,
      );

  Chapter toDomain({required String workId}) => Chapter(
        id: id,
        workId: workId,
        number: number,
        name: name,
        read: read,
      );
}
