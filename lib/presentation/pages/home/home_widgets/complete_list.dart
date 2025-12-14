import 'package:flutter/material.dart';
import '../../../../domain/entities/export_entities.dart';

class CompleteList extends StatelessWidget {
  final List<Order> complete;

  const CompleteList({super.key, required this.complete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: complete.length,
      itemBuilder: (_, i) {
        final order = complete[i];
        debugPrint('Rendering completed order: $i ${order}');
        return Card(
          color: Colors.green.shade100,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            title: Text("Order #${order.id}"),
            subtitle: Text(order.type == OrderType.vip ? "VIP" : "Normal"),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
        );
      },
    );
  }
}
