import 'package:database/database.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/notes_local_datasource.dart';
import '../data/repositories/notes_repository_impl.dart';
import '../domain/repositories/notes_repository.dart';
import '../domain/usecases/create_note.dart';
import '../domain/usecases/delete_note.dart';
import '../domain/usecases/get_notes.dart';
import '../domain/usecases/search_notes.dart';
import '../domain/usecases/toggle_favorite_note.dart';
import '../domain/usecases/toggle_pin_note.dart';
import '../domain/usecases/update_note.dart';
import '../presentation/bloc/notes_bloc.dart';

final getIt = GetIt.instance;

void initNotesFeature() {
  // Data sources
  getIt.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceImpl(getIt<NotesDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(getIt<NotesLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetNotes(getIt<NotesRepository>()));
  getIt.registerLazySingleton(() => CreateNote(getIt<NotesRepository>()));
  getIt.registerLazySingleton(() => UpdateNote(getIt<NotesRepository>()));
  getIt.registerLazySingleton(() => DeleteNote(getIt<NotesRepository>()));
  getIt.registerLazySingleton(() => SearchNotes(getIt<NotesRepository>()));
  getIt.registerLazySingleton(() => TogglePinNote(getIt<NotesRepository>()));
  getIt.registerLazySingleton(
    () => ToggleFavoriteNote(getIt<NotesRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => NotesBloc(
      getNotes: getIt<GetNotes>(),
      createNoteUseCase: getIt<CreateNote>(),
      updateNoteUseCase: getIt<UpdateNote>(),
      deleteNoteUseCase: getIt<DeleteNote>(),
      searchNotesUseCase: getIt<SearchNotes>(),
      togglePinNote: getIt<TogglePinNote>(),
      toggleFavoriteNote: getIt<ToggleFavoriteNote>(),
      repository: getIt<NotesRepository>(),
    ),
  );
}
