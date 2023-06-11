import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String name;
  final int score;

  const Task({this.id, required this.name, required this.score});

  @override
  List<Object?> get props => [id, name, score];
}
