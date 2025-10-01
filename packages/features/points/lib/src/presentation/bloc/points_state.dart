import 'package:equatable/equatable.dart';

import '../../domain/entities/point_transaction.dart';

sealed class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object?> get props => [];
}

final class PointsInitial extends PointsState {}

final class PointsLoading extends PointsState {}

final class PointsLoaded extends PointsState {
  final int balance;
  final List<PointTransaction> recentTransactions;

  const PointsLoaded({
    required this.balance,
    this.recentTransactions = const [],
  });

  @override
  List<Object?> get props => [balance, recentTransactions];
}

final class PointsSufficient extends PointsState {
  final int balance;
  final int required;

  const PointsSufficient({required this.balance, required this.required});

  @override
  List<Object?> get props => [balance, required];
}

final class PointsInsufficient extends PointsState {
  final int balance;
  final int required;
  final int shortfall;

  const PointsInsufficient({required this.balance, required this.required})
    : shortfall = required - balance;

  @override
  List<Object?> get props => [balance, required, shortfall];
}

final class PointsSpent extends PointsState {
  final int newBalance;
  final int amountSpent;
  final String message;

  const PointsSpent({
    required this.newBalance,
    required this.amountSpent,
    this.message = 'Points spent successfully',
  });

  @override
  List<Object?> get props => [newBalance, amountSpent, message];
}

final class PointsEarned extends PointsState {
  final int newBalance;
  final int amountEarned;
  final String message;

  const PointsEarned({
    required this.newBalance,
    required this.amountEarned,
    this.message = 'Points earned!',
  });

  @override
  List<Object?> get props => [newBalance, amountEarned, message];
}

final class PointsError extends PointsState {
  final String message;

  const PointsError(this.message);

  @override
  List<Object?> get props => [message];
}
