import 'package:equatable/equatable.dart';
import '../../domain/entities/export_entities.dart';

class InProgress extends Equatable {
  final int botId;
  final Order order;
  final DateTime startTime;
  final DateTime endTime;

  const InProgress({
    required this.botId,
    required this.order,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [botId, order, startTime, endTime];
}
