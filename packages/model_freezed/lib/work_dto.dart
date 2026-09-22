import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core_domain/core_domain.dart';

part 'work_dto.freezed.dart';
part 'work_dto.g.dart';

@freezed
abstract class WorkDto with _$WorkDto {
  const WorkDto._();
  const factory WorkDto({
    required String id,
    required String title,
    required String author,
    @Default('') String coverUrl,
    @Default('') String description,
  }) = _WorkDto;

  factory WorkDto.fromJson(Map<String, dynamic> json) => _$WorkDtoFromJson(json);

  Work toDomain() => Work(
        id: id,
        title: title,
        author: author,
        coverUrl: coverUrl,
        description: description,
      );
}
