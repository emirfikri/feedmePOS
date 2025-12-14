import 'package:equatable/equatable.dart';

enum OrderType { normal, vip }

enum OrderStatus { pending, processing, complete }

class Order extends Equatable {
  final int id;
  final OrderType type;
  final OrderStatus status;

  const Order({required this.id, required this.type, required this.status});

  Order copyWith({OrderStatus? status}) =>
      Order(id: id, type: type, status: status ?? this.status);

  @override
  List<Object?> get props => [id, type, status];
}
