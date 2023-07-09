import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';
import 'todo_tile.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    // List lastMonth = ref.read(todoStateProvider.notifier).last30days();
    var completedList = listData
        .where((element) => element.isCompleted == 1
            //            &&lastMonth.contains(element.date!.substring(0, 10))
            )
        .toList();

    return ListView.builder(
      itemCount: completedList.length,
      itemBuilder: (context, index) {
        final data = completedList[index];
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(
                  data.id!,
                );
          },
          editWidget: const SizedBox.shrink(),
          text: data.title,
          color: color,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          switcher: const Icon(AntDesign.checkcircle, color: Colors.green),
        );
      },
    );
  }
}
