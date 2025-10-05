import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:points/points.dart';

import '../../domain/repositories/notes_repository.dart';
import '../../domain/usecases/create_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/search_notes.dart';
import '../../domain/usecases/toggle_favorite_note.dart';
import '../../domain/usecases/toggle_pin_note.dart';
import '../../domain/usecases/update_note.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotes getNotes;
  final CreateNote createNoteUseCase;
  final UpdateNote updateNoteUseCase;
  final DeleteNote deleteNoteUseCase;
  final SearchNotes searchNotesUseCase;
  final TogglePinNote togglePinNote;
  final ToggleFavoriteNote toggleFavoriteNote;
  final NotesRepository repository;
  final PointsBloc pointsBloc;

  NotesBloc({
    required this.getNotes,
    required this.createNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.searchNotesUseCase,
    required this.togglePinNote,
    required this.toggleFavoriteNote,
    required this.repository,
    required this.pointsBloc,
  }) : super(const NotesInitial()) {
    on<NotesLoad>(_onLoadNotes);
    on<NotesByCategoryLoad>(_onLoadNotesByCategory);
    on<PinnedNotesLoad>(_onLoadPinnedNotes);
    on<FavoriteNotesLoad>(_onLoadFavoriteNotes);
    on<NotesSearch>(_onSearchNotes);
    on<NoteCreationRequest>(_onRequestNoteCreation);
    on<NoteCreate>(_onCreateNote);
    on<NoteEditRequest>(_onRequestNoteEdit);
    on<NoteUpdate>(_onUpdateNote);
    on<NotePreviewRequest>(_onRequestNotePreview);
    on<NoteDeletionRequest>(_onRequestNoteDeletion);
    on<NoteDelete>(_onDeleteNote);
    on<PinNoteToggle>(_onTogglePinNote);
    on<FavoriteNoteToggle>(_onToggleFavoriteNote);
    on<NotesRefresh>(_onRefreshNotes);
  }

  Future<void> _onLoadNotes(NotesLoad event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    final result = await getNotes();

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onLoadNotesByCategory(
    NotesByCategoryLoad event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final result = await repository.getNotesByCategory(event.categoryId);

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onLoadPinnedNotes(
    PinnedNotesLoad event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final result = await repository.getPinnedNotes();

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onLoadFavoriteNotes(
    FavoriteNotesLoad event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final result = await repository.getFavoriteNotes();

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onSearchNotes(
    NotesSearch event,
    Emitter<NotesState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      add(NotesLoad());
      return;
    }

    emit(NotesLoading());

    final result = await searchNotesUseCase(event.query);

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesSearchResults(results: notes, query: event.query)),
    );
  }

  Future<void> _onRequestNoteCreation(
    NoteCreationRequest event,
    Emitter<NotesState> emit,
  ) async {
    // Get point cost based on note type
    final pointCost = PointCosts.getCostForNoteType(event.noteType.name);

    // Check if user has enough points
    pointsBloc.add(CheckPointsEvent(pointCost));

    // Wait for points check result
    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'create',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
        ),
      );
    } else if (pointsState is PointsSufficient) {
      // User has enough points, but we still need them to spend
      // We'll emit a state indicating they can proceed
      emit(
        NoteActionRequiresChallenge(
          action: 'create',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
        ),
      );
    } else {
      emit(const NotesError('Unable to check points'));
    }
  }

  Future<void> _onCreateNote(NoteCreate event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    // First, spend the points
    final pointCost = PointCosts.getCostForNoteType(event.noteType.name);

    pointsBloc.add(
      SpendPointsEvent(
        amount: pointCost,
        reason: 'note_created',
        description: 'Created ${event.noteType.displayName} note',
      ),
    );

    // Wait for points to be spent
    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'create',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
        ),
      );
      return;
    }

    // Points spent successfully, create the note
    final params = CreateNoteParams(
      title: event.title,
      content: event.content,
      noteType: event.noteType,
      categoryId: event.categoryId,
      color: event.color,
    );

    final result = await createNoteUseCase(params);

    result.fold((failure) => emit(NotesError(failure.message)), (note) {
      AudioManager().playNoteCreated();

      // Emit event via EventBus
      AppEventBus().emit(
        NoteCreatedEvent(noteId: note.id, noteType: note.noteType.name),
      );

      emit(NoteCreated(note: note));

      // Reload notes
      add(NotesLoad());
    });
  }

  Future<void> _onRequestNoteEdit(
    NoteEditRequest event,
    Emitter<NotesState> emit,
  ) async {
    final pointCost = PointCosts.editNote;

    // Check if user has enough points
    pointsBloc.add(CheckPointsEvent(pointCost));

    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'edit',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else if (pointsState is PointsSufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'edit',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else {
      emit(const NotesError('Unable to check points'));
    }
  }

  Future<void> _onUpdateNote(NoteUpdate event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    // First, spend the points
    final pointCost = PointCosts.editNote;

    pointsBloc.add(
      SpendPointsEvent(
        amount: pointCost,
        reason: 'note_edited',
        description: 'Edited note',
        relatedNoteId: event.id,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'edit',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.id,
        ),
      );
      return;
    }

    // Points spent successfully, update the note
    final params = UpdateNoteParams(
      id: event.id,
      title: event.title,
      content: event.content,
      categoryId: event.categoryId,
      color: event.color,
    );

    final result = await updateNoteUseCase(params);

    result.fold((failure) => emit(NotesError(failure.message)), (note) {
      // Emit event via EventBus
      AppEventBus().emit(NoteUpdatedEvent(note.id));

      emit(NoteUpdated(note: note));

      // Reload notes
      add(NotesLoad());
    });
  }

  Future<void> _onRequestNotePreview(
    NotePreviewRequest event,
    Emitter<NotesState> emit,
  ) async {
    final pointCost = PointCosts.previewNote;
    // Check if user has enough points
    pointsBloc.add(CheckPointsEvent(pointCost));

    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'preview',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else if (pointsState is PointsSufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'preview',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else {
      emit(const NotesError('Unable to check points'));
    }
  }

  Future<void> _onRequestNoteDeletion(
    NoteDeletionRequest event,
    Emitter<NotesState> emit,
  ) async {
    final pointCost = PointCosts.deleteNote;

    // Check if user has enough points
    pointsBloc.add(CheckPointsEvent(pointCost));

    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'delete',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else if (pointsState is PointsSufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'delete',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
    } else {
      emit(const NotesError('Unable to check points'));
    }
  }

  Future<void> _onDeleteNote(NoteDelete event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    // First, spend the points
    final pointCost = PointCosts.deleteNote;

    pointsBloc.add(
      SpendPointsEvent(
        amount: pointCost,
        reason: 'note_deleted',
        description: 'Deleted note',
        relatedNoteId: event.noteId,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    final pointsState = pointsBloc.state;

    if (pointsState is PointsInsufficient) {
      emit(
        NoteActionRequiresChallenge(
          action: 'delete',
          pointCost: pointCost,
          currentPoints: pointsState.balance,
          noteId: event.noteId,
        ),
      );
      return;
    }

    // Points spent successfully, delete the note
    final result = await deleteNoteUseCase(event.noteId);

    result.fold((failure) => emit(NotesError(failure.message)), (_) {
      // Emit event via EventBus
      AppEventBus().emit(NoteDeletedEvent(event.noteId));

      emit(const NoteDeleted());

      // Reload notes
      add(NotesLoad());
    });
  }

  Future<void> _onTogglePinNote(
    PinNoteToggle event,
    Emitter<NotesState> emit,
  ) async {
    final result = await togglePinNote(event.noteId);

    result.fold((failure) => emit(NotesError(failure.message)), (note) {
      final message = note.isPinned ? 'Note pinned' : 'Note unpinned';
      emit(NoteToggled(note: note, message: message));

      // Reload notes to reflect changes
      add(NotesLoad());
    });
  }

  Future<void> _onToggleFavoriteNote(
    FavoriteNoteToggle event,
    Emitter<NotesState> emit,
  ) async {
    final result = await toggleFavoriteNote(event.noteId);

    result.fold((failure) => emit(NotesError(failure.message)), (note) {
      final message = note.isFavorite
          ? 'Added to favorites'
          : 'Removed from favorites';
      emit(NoteToggled(note: note, message: message));

      // Reload notes to reflect changes
      add(NotesLoad());
    });
  }

  Future<void> _onRefreshNotes(
    NotesRefresh event,
    Emitter<NotesState> emit,
  ) async {
    // Don't show loading indicator for refresh
    final result = await getNotes();

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }
}
