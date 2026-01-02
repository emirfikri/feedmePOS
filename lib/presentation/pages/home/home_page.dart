import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/export_bloc.dart';

import 'home_widgets/export_home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OrderBloc>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("McD Bot Queue"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "In Progress"),
              Tab(text: "Completed"),
              Tab(text: "Bots"),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 8),

            // Buttons Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => bloc.add(NewNormalOrder()),
                      child: const Text("New Normal Order"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => bloc.add(NewVipOrder()),
                      child: const Text("New VIP Order"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Tab Views
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (_, __) {
                      return TabBarView(
                        children: [
                          PendingList(
                            pending: state.pending,
                            bots: state.bots.length,
                          ),
                          InProgressList(inProgress: state.inProgress),
                          CompleteList(complete: state.complete),
                          BotsList(
                            bots: state.bots,
                            inProgress: state.inProgress,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: "addfastBot",
              onPressed: () => bloc.add(AddFastBot()),
              label: const Text("Add Fast Bot"),
              icon: const Icon(Icons.add),
            ),
            FloatingActionButton.extended(
              heroTag: "addBot",
              onPressed: () => bloc.add(AddBot()),
              label: const Text("Add Bot"),
              icon: const Icon(Icons.add),
            ),
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: "removeBot",
              onPressed: () => bloc.add(RemoveBot()),
              label: const Text("Remove Bot"),
              icon: const Icon(Icons.remove),
              backgroundColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
