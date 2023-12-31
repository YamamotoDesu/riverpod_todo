import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:riverpod_todo/features/todo/pages/update_page.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../controllers/todo/todo_provider.dart';
import 'todo_tile.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);

    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, index) {
        final data = todayList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(
                  data.id!,
                );
          },
          editWidget: GestureDetector(
            onTap: () {
              myTitle = data.title.toString();
              myDesc = data.desc.toString();
              mySchedule = data.date.toString();
              myStartDate = data.startTime.toString();
              myEndDate = data.endTime.toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateTask(
                    id: data.id ?? 0,
                  ),
                ),
              );
            },
            child: Icon(
              MdiIcons.circleEditOutline,
              color: Colors.grey,
            ),
          ),
          text: data.title,
          color: color,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
              ref.read(todoStateProvider.notifier).markAsCompled(
                    data.id ?? 0,
                    data.title.toString(),
                    data.desc.toString(),
                    1,
                    data.date.toString(),
                    data.startTime.toString(),
                    data.endTime.toString(),
                  );
            },
          ),
        );
      },
    );
  }
}
