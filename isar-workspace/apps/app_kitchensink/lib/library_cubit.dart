import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_domain/core_domain.dart';

sealed class LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<Work> works;
  LibraryLoaded(this.works);
}

class LibraryError extends LibraryState {
  final Object error;
  LibraryError(this.error);
}

class LibraryCubit extends Cubit<LibraryState> {
  final WorkRepository repo;
  LibraryCubit(this.repo) : super(LibraryLoading());

  Future<void> load() async {
    try {
      emit(LibraryLoaded(await repo.getLibrary()));
    } catch (e) {
      emit(LibraryError(e));
    }
  }
}
