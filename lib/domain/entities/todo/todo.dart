import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:fluttertodo/utils/constants.dart';

@Entity(tableName: kTodosTableName)
class Todo extends Equatable {
  final String task;

  @PrimaryKey(autoGenerate: true)
  final int? id;

  Todo({required this.task, required this.id});

  @override
  List<Object> get props => [task, id!];
}
