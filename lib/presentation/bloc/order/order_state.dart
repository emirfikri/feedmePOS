import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/entities/in_progress.dart';

class OrderState extends Equatable {
  final int bots;
  final List<Order> pending;
  final List<InProgress> inProgress;
  final List<Order> complete;

  const OrderState({
    this.bots = 0,
    this.pending = const [],
    this.inProgress = const [],
    this.complete = const [],
  });

  OrderState copyWith({
    int? bots,
    List<Order>? pending,
    List<InProgress>? inProgress,
    List<Order>? complete,
  }) {
    return OrderState(
      bots: bots ?? this.bots,
      pending: pending ?? this.pending,
      inProgress: inProgress ?? this.inProgress,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object?> get props => [bots, pending, inProgress, complete];
}
