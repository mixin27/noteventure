library;

export 'src/data/datasources/notes_local_datasource.dart';
export 'src/data/repositories/notes_repository_impl.dart';

// Domain - Repositories
export 'src/domain/repositories/notes_repository.dart';

// Domain - Entities
export 'src/domain/entities/note.dart';
export 'src/domain/entities/category.dart';

// Presentation - BLoC
export 'src/presentation/bloc/notes_bloc.dart';
export 'src/presentation/bloc/notes_event.dart';
export 'src/presentation/bloc/notes_state.dart';

// Presentation - Pages
export 'src/presentation/pages/note_detail_page.dart';
export 'src/presentation/pages/note_editor_page.dart';

// DI
export 'src/di/notes_injection.dart' show initNotesFeature;
