import 'package:flutter/material.dart';
import '../../../../domain/entities/export_entities.dart';

class PendingList extends StatelessWidget {
  final List<Order> pending;
  final int bots;

  const PendingList({super.key, required this.pending, required this.bots});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pending.length,
      itemBuilder: (_, i) {
        final order = pending[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            title: Text(
              "Order #${order.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              order.type == OrderType.vip ? "VIP Order" : "Normal Order",
            ),
            trailing: const Icon(Icons.hourglass_empty),
          ),
        );
      },
    );
  }
}
