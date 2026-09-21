import 'package:dart_mappable/dart_mappable.dart';
import 'package:core_domain/core_domain.dart';

part 'work_dto.mapper.dart';

@MappableClass()
class WorkDto with WorkDtoMappable {
  final String id, title, author, coverUrl, description;
  const WorkDto({
    required this.id,
    required this.title,
    required this.author,
    this.coverUrl = '',
    this.description = '',
  });

  Work toDomain() => Work(
        id: id,
        title: title,
        author: author,
        coverUrl: coverUrl,
        description: description,
      );
}
