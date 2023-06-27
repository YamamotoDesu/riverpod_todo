import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/helpers/db_helper.dart';
import '../../../../common/models/task_model.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();

    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  void updateItem(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startItem,
    String endTime,
  ) async {
    await DBHelper.updateItem(
      id,
      title,
      desc,
      isCompleted,
      date,
      startItem,
      endTime,
    );
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markAsCompled(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startItem,
    String endTime,
  ) async {
    await DBHelper.updateItem(
      id,
      title,
      desc,
      1,
      date,
      startItem,
      endTime,
    );
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();

    return today.toString().substring(0, 10);
  }

  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneOmnthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneOmnthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? isCompleted;

    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }
}
