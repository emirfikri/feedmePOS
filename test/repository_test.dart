import 'package:flutter_test/flutter_test.dart';
import 'package:mcd_bot/data/repository/in_memory_repository.dart';
import 'package:mcd_bot/domain/entities/order.dart';

void main() {
  test('VIP orders inserted before normals', () {
    final repo = InMemoryRepository();
    final n1 = repo.create(OrderType.normal);
    final v1 = repo.create(OrderType.vip);
    expect(repo.pending.first.id, v1.id);
    expect(repo.pending.last.id, n1.id);
  });
}
