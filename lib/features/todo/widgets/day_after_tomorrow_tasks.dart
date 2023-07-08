import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/xpansion_title.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/update_page.dart';

class DayAfterList extends ConsumerWidget {
  const DayAfterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String dayafter = ref.read(todoStateProvider.notifier).getAfterTomorrow();

    var tomorrowTasks = todos.where(
      (element) => element.date!.contains(dayafter),
    );
    return XpansionTile(
      text: DateTime.now()
          .add(
            const Duration(
              days: 2,
            ),
          )
          .toString()
          .substring(5, 10),
      text2: "Day After tomorrow's tasks are shown here",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionState1Provider.notifier).setStart(expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w, top: 25.0.h),
        child: ref.watch(xpansionState1Provider)
            ? const Icon(
                AntDesign.closecircleo,
                color: AppConst.kBlueLight,
              )
            : const Icon(
                AntDesign.circledown,
                color: AppConst.kGreen,
              ),
      ),
      children: [
        for (final todo in tomorrowTasks)
          TodoTile(
            text: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
            },
            editWidget: GestureDetector(
              onTap: () {
                myTitle = todo.title.toString();
                myDesc = todo.desc.toString();
                mySchedule = todo.date.toString();
                myStartDate = todo.startTime.toString();
                myEndDate = todo.endTime.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTask(
                      id: todo.id ?? 0,
                    ),
                  ),
                );
              },
              child: Icon(
                MdiIcons.circleEditOutline,
                color: Colors.grey,
              ),
            ),
            switcher: const SizedBox.shrink(),
          ),
      ],
    );
  }
}
