import 'dart:async';

import 'package:floor/floor.dart';
import 'package:fluttertodo/data/datasources/local/todo_dao.dart';
import '../../domain/entities/todo/todo.dart';
import 'converters/SourceTypeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
