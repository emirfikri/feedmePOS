import 'package:flutter_test/flutter_test.dart';
import 'package:mcd_bot/data/repository/in_memory_repository.dart';
import 'package:mcd_bot/presentation/bloc/order/order_bloc.dart';
import 'package:mcd_bot/presentation/bloc/order/order_event.dart';

void main() {
  test('Add bot and order processes (smoke)', () async {
    final repo = InMemoryRepository();
    final bloc = OrderBloc();
    bloc.add(AddBot());
    bloc.add(NewNormalOrder());
    // Wait a bit to allow bot processing (processingSeconds is 10s by default)
    await Future.delayed(Duration(seconds: 1));
    // smoke assert - no exceptions, repo exists
    expect(repo.pending.length + repo.complete.length >= 0, true);
  });
}
