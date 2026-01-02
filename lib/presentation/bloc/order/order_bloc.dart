import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants.dart' as Constants;
import '../../../domain/entities/export_entities.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  int _nextOrderId = 1;
  int _nextBotId = 1;

  final Map<int, Timer> _botTimers = {};

  OrderBloc() : super(const OrderState()) {
    on<NewNormalOrder>(_onNewNormalOrder);
    on<NewVipOrder>(_onNewVipOrder);
    on<AddBot>(_onAddBot);
    on<AddFastBot>(_onAddFastBot);
    on<RemoveBot>(_onRemoveBot);
    on<BotFinishedOrder>(_onBotFinished);
  }

  // --------------------------------------------------------------------
  // NEW NORMAL ORDER
  // --------------------------------------------------------------------
  void _onNewNormalOrder(NewNormalOrder event, Emitter<OrderState> emit) {
    final order = Order(
      id: _nextOrderId++,
      type: OrderType.normal,
      status: OrderStatus.pending,
    );

    emit(state.copyWith(pending: [...state.pending, order]));
    _assignToBots(emit);
  }

  // --------------------------------------------------------------------
  // NEW VIP ORDER
  // --------------------------------------------------------------------
  void _onNewVipOrder(NewVipOrder event, Emitter<OrderState> emit) {
    final order = Order(
      id: _nextOrderId++,
      type: OrderType.vip,
      status: OrderStatus.pending,
    );

    final updated = List<Order>.from(state.pending);
    final vipIndex = updated.lastIndexWhere((o) => o.type == OrderType.vip) + 1;

    updated.insert(vipIndex, order);
    emit(state.copyWith(pending: updated));

    _assignToBots(emit);
  }

  // --------------------------------------------------------------------
  // ADD BOT
  // --------------------------------------------------------------------
  void _onAddBot(AddBot event, Emitter<OrderState> emit) {
    final bot = Bots(id: _nextBotId, isFast: false);
    emit(state.copyWith(bots: [...state.bots, bot]));
    _nextBotId++;

    _assignToBots(emit);
  }

  void _onAddFastBot(AddFastBot event, Emitter<OrderState> emit) {
    final bot = Bots(id: _nextBotId, isFast: true);
    emit(state.copyWith(bots: [...state.bots, bot]));
    _nextBotId++;

    _assignToBots(emit);
  }

  // --------------------------------------------------------------------
  // REMOVE BOT
  // --------------------------------------------------------------------
  void _onRemoveBot(RemoveBot event, Emitter<OrderState> emit) {
    if (state.bots == 0) return;

    final botIdToRemove = _nextBotId - 1;
    _nextBotId--;

    // cancel timer
    _botTimers[botIdToRemove]?.cancel();
    _botTimers.remove(botIdToRemove);

    // return its processing order to pending
    final processed = state.inProgress.where((p) => p.botId == botIdToRemove);

    final updatedPending = List<Order>.from(state.pending);
    for (final p in processed) {
      updatedPending.insert(
        0,
        Order(
          id: p.order.id,
          type: p.order.type, // fallback, cannot detect VIP anymore
          status: OrderStatus.pending,
        ),
      );
    }

    final updatedInProgress = state.inProgress
        .where((p) => p.botId != botIdToRemove)
        .toList();

    emit(
      state.copyWith(
        bots: [...state.bots]..removeAt(state.bots.length - 1),
        pending: updatedPending,
        inProgress: updatedInProgress,
      ),
    );
  }

  // --------------------------------------------------------------------
  // BOT FINISHED TASK
  // --------------------------------------------------------------------
  void _onBotFinished(BotFinishedOrder event, Emitter<OrderState> emit) {
    _botTimers[event.botId]?.cancel();
    _botTimers.remove(event.botId);

    final updatedInProgress = state.inProgress
        .where((p) => p.order.id != event.order.id)
        .toList();

    // move to completed — treat as normal (you can improve this)
    final completedOrder = Order(
      id: event.order.id,
      type: event.order.type,
      status: OrderStatus.complete,
    );

    emit(
      state.copyWith(
        inProgress: updatedInProgress,
        complete: [...state.complete, completedOrder],
      ),
    );

    _assignToBots(emit);
  }

  // --------------------------------------------------------------------
  // ASSIGN BOT ENGINE
  // --------------------------------------------------------------------
  void _assignToBots(Emitter<OrderState> emit) {
    int idleBots = state.bots.length - state.inProgress.length;
    if (idleBots <= 0) return;
    if (state.pending.isEmpty) return;

    final pending = List<Order>.from(state.pending);
    final inProg = List<InProgress>.from(state.inProgress);

    while (idleBots > 0 && pending.isNotEmpty) {
      final botId = _findFreeBotId();
      if (botId == null) break;

      final order = pending.removeAt(0);

      final now = DateTime.now();

      final isFastBot = state.bots.firstWhere((b) => b.id == botId).isFast;
      final finish = now.add(
        Duration(
          seconds: isFastBot
              ? Constants.fastProcessingSeconds
              : Constants.processingSeconds,
        ),
      );
      inProg.add(
        InProgress(botId: botId, order: order, startTime: now, endTime: finish),
      );

      _botTimers[botId] = Timer(
        Duration(
          seconds: isFastBot
              ? Constants.fastProcessingSeconds
              : Constants.processingSeconds,
        ),
        () => add(BotFinishedOrder(botId, order)),
      );

      idleBots--;
    }

    emit(state.copyWith(pending: pending, inProgress: inProg));
  }

  int? _findFreeBotId() {
    final used = state.inProgress.map((e) => e.botId).toSet();
    for (int i = 1; i < _nextBotId; i++) {
      if (!used.contains(i)) return i;
    }
    return null;
  }
}
