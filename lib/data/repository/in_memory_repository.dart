
import '../../domain/entities/export_entities.dart';

/// Simple in-memory repository used for local prototype and tests.
class InMemoryRepository {
  final List<Order> _pending = [];
  final List<Order> _complete = [];
  int _nextId = 1;

  List<Order> get pending => List.unmodifiable(_pending);
  List<Order> get complete => List.unmodifiable(_complete);

  Order create(OrderType type) {
    final order = Order(id: _nextId++, type: type, status: OrderStatus.pending);
    if (type == OrderType.vip) {
      final idx = _pending.indexWhere((o) => o.type == OrderType.normal);
      if (idx == -1) _pending.add(order);
      else _pending.insert(idx, order);
    } else {
      _pending.add(order);
    }
    return order;
  }

  Order? popNext() {
    if (_pending.isEmpty) return null;
    return _pending.removeAt(0);
  }

  void requeueFront(Order order) {
    _pending.insert(0, order.copyWith(status: OrderStatus.pending));
  }

  void markComplete(Order order) {
    _complete.add(order.copyWith(status: OrderStatus.complete));
  }

  void reset() {
    _pending.clear();
    _complete.clear();
    _nextId = 1;
  }
}
