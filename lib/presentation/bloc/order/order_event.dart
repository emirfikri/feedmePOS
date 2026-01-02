import 'package:mcd_bot/domain/entities/export_entities.dart';

abstract class OrderEvent {}

class NewNormalOrder extends OrderEvent {}

class NewVipOrder extends OrderEvent {}

class AddBot extends OrderEvent {}

class AddFastBot extends OrderEvent {}

class RemoveBot extends OrderEvent {}

class BotFinishedOrder extends OrderEvent {
  final int botId;
  final Order order;

  BotFinishedOrder(this.botId, this.order);
}
