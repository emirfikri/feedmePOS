import 'package:flutter/material.dart';

import '../../../../domain/entities/export_entities.dart';

class InProgressList extends StatelessWidget {
  final List<InProgress> inProgress;

  const InProgressList({super.key, required this.inProgress});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inProgress.length,
      itemBuilder: (_, i) {
        final p = inProgress[i];

        final secondsLeft = p.endTime
            .difference(DateTime.now())
            .inSeconds
            .clamp(0, 999);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(child: Text("B${p.botId}")),
            title: Text("Order #${p.order.id} (${p.order.type.name})"),
            subtitle: Text("Finishing in: $secondsLeft sec"),
            trailing: const Icon(Icons.precision_manufacturing),
          ),
        );
      },
    );
  }
}
