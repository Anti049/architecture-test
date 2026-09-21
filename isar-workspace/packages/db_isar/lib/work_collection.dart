import 'package:isar_community/isar.dart';

part 'work_collection.g.dart';

@collection
class WorkModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String uid;
  late String title;
  late String author;
  String coverUrl = '';
  String description = '';
}
