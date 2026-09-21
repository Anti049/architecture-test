class Work {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final List<Chapter> chapters;

  const Work({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    this.chapters = const [],
  });
}

class Chapter {
  final String id;
  final String workId;
  final int number;
  final String name;
  final bool read;
  const Chapter({
    required this.id,
    required this.workId,
    required this.number,
    required this.name,
    this.read = false,
  });
}
