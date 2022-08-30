const String kTodosTableName = "todoList";

const String kDatabaseName = 'app_database.db';

String getTaskTitle(String task) {
  if (task.length > 20) {
    return task.substring(0, 20);
  } else {
    return task;
  }
}

String getTaskBodyPreview(String task) {
  if (task.length > 20) {
    if (task.length > 120) {
      return task.substring(20, 120);
    } else {
      return task.substring(20);
    }
  } else {
    return '';
  }
}

String getTaskFullBody(String task) {
  return task;
}
