import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import '../../domain/repositories/points_repository.dart';
import '../../domain/usecases/check_points.dart';
import '../../domain/usecases/earn_points.dart';
import '../../domain/usecases/get_point_balance.dart';
import '../../domain/usecases/spend_points.dart';
import 'points_event.dart';
import 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final GetPointBalance getPointBalance;
  final CheckPoints checkPoints;
  final SpendPoints spendPointsUseCase;
  final EarnPoints earnPointsUseCase;
  final PointsRepository repository;

  StreamSubscription? _eventBusSubscription;

  PointsBloc({
    required this.getPointBalance,
    required this.checkPoints,
    required this.spendPointsUseCase,
    required this.earnPointsUseCase,
    required this.repository,
  }) : super(PointsInitial()) {
    on<LoadPointBalance>(_onLoadPointBalance);
    on<SpendPointsEvent>(_onSpendPoints);
    on<EarnPointsEvent>(_onEarnPoints);
    on<CheckPointsEvent>(_onCheckPoints);
    on<LoadTransactionsEvent>(_onLoadTransactions);

    // Listen to EventBus for point changes from other features
    _eventBusSubscription = AppEventBus().on<PointsChangedEvent>().listen((
      event,
    ) {
      add(LoadPointBalance());
    });
  }

  Future<void> _onLoadPointBalance(
    LoadPointBalance event,
    Emitter<PointsState> emit,
  ) async {
    emit(PointsLoading());

    final result = await getPointBalance();

    result.fold(
      (failure) => emit(PointsError(failure.message)),
      (balance) => emit(PointsLoaded(balance: balance)),
    );
  }

  Future<void> _onSpendPoints(
    SpendPointsEvent event,
    Emitter<PointsState> emit,
  ) async {
    final params = SpendPointsParams(
      amount: event.amount,
      reason: event.reason,
      description: event.description,
      relatedNoteId: event.relatedNoteId,
    );

    final result = await spendPointsUseCase(params);

    result.fold(
      (failure) {
        if (failure is InsufficientPointsFailure) {
          emit(
            PointsInsufficient(
              balance: failure.current,
              required: failure.required,
            ),
          );
        } else {
          emit(PointsError(failure.message));
        }
      },
      (newBalance) {
        emit(PointsSpent(newBalance: newBalance, amountSpent: event.amount));
        // Reload balance
        add(LoadPointBalance());
      },
    );
  }

  Future<void> _onEarnPoints(
    EarnPointsEvent event,
    Emitter<PointsState> emit,
  ) async {
    final params = EarnPointsParams(
      amount: event.amount,
      reason: event.reason,
      description: event.description,
      relatedChallengeId: event.relatedChallengeId,
    );

    final result = await earnPointsUseCase(params);

    result.fold((failure) => emit(PointsError(failure.message)), (newBalance) {
      emit(PointsEarned(newBalance: newBalance, amountEarned: event.amount));
      // Reload balance
      add(LoadPointBalance());
    });
  }

  Future<void> _onCheckPoints(
    CheckPointsEvent event,
    Emitter<PointsState> emit,
  ) async {
    final balanceResult = await getPointBalance();
    final checkResult = await checkPoints(event.required);

    balanceResult.fold((failure) => emit(PointsError(failure.message)), (
      balance,
    ) {
      checkResult.fold((failure) => emit(PointsError(failure.message)), (
        hasEnough,
      ) {
        if (hasEnough) {
          emit(PointsSufficient(balance: balance, required: event.required));
        } else {
          emit(PointsInsufficient(balance: balance, required: event.required));
        }
      });
    });
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<PointsState> emit,
  ) async {
    final balanceResult = await getPointBalance();
    final transactionsResult = event.limit != null
        ? await repository.getRecentTransactions(event.limit!)
        : await repository.getAllTransactions();

    balanceResult.fold((failure) => emit(PointsError(failure.message)), (
      balance,
    ) {
      transactionsResult.fold(
        (failure) => emit(PointsError(failure.message)),
        (transactions) => emit(
          PointsLoaded(balance: balance, recentTransactions: transactions),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _eventBusSubscription?.cancel();
    return super.close();
  }
}
