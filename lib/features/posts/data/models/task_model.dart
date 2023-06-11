
import '../../domain/entities/task.dart';


class TaskModel extends Task {
  const TaskModel({int? id, required String name, required int score})
      : super(id: id, name: name, score: score);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(id: json['id'], name: json['name'], score: json['score']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score};
  }
}
