import 'package:flutter/material.dart';
import 'package:mcd_bot/domain/entities/bots.dart';
import '../../../../domain/entities/export_entities.dart';

class BotsList extends StatelessWidget {
  final List<InProgress> inProgress;
  final List<Bots> bots;

  const BotsList({super.key, required this.inProgress, required this.bots});

  @override
  Widget build(BuildContext context) {
    final busyBotIds = inProgress.map((e) => e.botId).toSet();

    return ListView.builder(
      itemCount: bots.length,
      itemBuilder: (_, i) {
        final botId = bots[i].id;
        final isBusy = busyBotIds.contains(botId);
        final isFast = bots[i].isFast;
        final progress = isBusy
            ? inProgress.firstWhere((p) => p.botId == botId)
            : null;

        final secondsLeft = isBusy
            ? progress!.endTime.difference(DateTime.now()).inSeconds
            : null;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isBusy ? Colors.orange.shade100 : Colors.green.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isBusy ? Colors.orange : Colors.green,
              child: Text("B$botId"),
            ),
            title: Text(
              isBusy ? "Processing Order #${progress!.order.id}" : "Available",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: isBusy
                ? Text("Ends in: ${secondsLeft! < 0 ? 0 : secondsLeft}s")
                : const Text("Idle"),
            trailing: Column(
              children: [
                Text(isFast ? "Fast Bot" : "Normal Bot"),
                Icon(
                  isBusy ? Icons.precision_manufacturing : Icons.check_circle,
                  color: isBusy ? Colors.orange : Colors.green,
                  size: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
