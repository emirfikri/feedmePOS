import 'package:equatable/equatable.dart';

class Bots extends Equatable {
  final int id;
  final bool isFast;

  const Bots({required this.id, required this.isFast});

  @override
  List<Object?> get props => [id, isFast];
}
