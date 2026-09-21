import 'package:core_domain/core_domain.dart';

/// Hand-written immutable DTO (the "None" immutable-class option).
/// Demonstrates the boilerplate that Freezed / dart_mappable remove.
class WorkDto {
  final String id, title, author, coverUrl, description;
  const WorkDto({
    required this.id,
    required this.title,
    required this.author,
    this.coverUrl = '',
    this.description = '',
  });

  factory WorkDto.fromJson(Map<String, dynamic> j) => WorkDto(
        id: j['id'] as String,
        title: j['title'] as String,
        author: j['author'] as String,
        coverUrl: j['coverUrl'] as String? ?? '',
        description: j['description'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'description': description,
      };

  WorkDto copyWith({String? title}) => WorkDto(
        id: id,
        title: title ?? this.title,
        author: author,
        coverUrl: coverUrl,
        description: description,
      );

  Work toDomain() => Work(
        id: id,
        title: title,
        author: author,
        coverUrl: coverUrl,
        description: description,
      );

  @override
  bool operator ==(Object other) =>
      other is WorkDto &&
      other.id == id &&
      other.title == title &&
      other.author == author &&
      other.coverUrl == coverUrl &&
      other.description == description;

  @override
  int get hashCode => Object.hash(id, title, author, coverUrl, description);
}
