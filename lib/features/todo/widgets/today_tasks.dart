import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';
import 'todo_tile.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);

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
            onTap: () {},
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
