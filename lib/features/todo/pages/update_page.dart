import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../../common/models/task_model.dart';
import '../../../common/widgets/appstyle.dart';
import '../../../common/widgets/custom_otn_btn.dart';
import '../../../common/widgets/custom_text.dart';
import '../../../common/widgets/height_spacer.dart';
import '../controllers/dates/dates_provider.dart';
import '../controllers/todo/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({
    super.key,
    required this.id,
  });

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends ConsumerState<UpdateTask> {
  final TextEditingController title = TextEditingController(text: myTitle);
  final TextEditingController desc = TextEditingController(text: myDesc);

  @override
  Widget build(BuildContext context) {
    _initDate();
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "AddTitle",
              controller: title,
              hintStyle: appstyle(
                16,
                AppConst.kGreyLight,
                FontWeight.w600,
              ),
            ),
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "Add description",
              controller: desc,
              hintStyle: appstyle(
                16,
                AppConst.kGreyLight,
                FontWeight.w600,
              ),
            ),
            const HeightSpacer(height: 20),
            CustomOtlnBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 6, 1),
                    maxTime: DateTime(2024, 6, 1),
                    theme: const picker.DatePickerTheme(
                      doneStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ), onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setDate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kLight,
              color2: AppConst.kBlueLight,
              text: scheduleDate == ""
                  ? "Set Date"
                  : scheduleDate.substring(0, 10),
            ),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.jp);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: start == "" ? "Start Time" : start.substring(10, 16)),
                CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.jp);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: finish == ""
                        ? "Finish Time"
                        : finish.substring(10, 16)),
              ],
            ),
            const HeightSpacer(height: 20),
            CustomOtlnBtn(
              onTap: () {
                if (title.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    start.isNotEmpty &&
                    finish.isNotEmpty) {
                  ref.read(todoStateProvider.notifier).updateItem(
                        widget.id,
                        title.text,
                        desc.text,
                        0,
                        scheduleDate,
                        start,
                        finish,
                      );
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.pop(context);
                } else {
                  print("failed to add task");
                }
              },
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kLight,
              color2: AppConst.kGreen,
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }

  void _initDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dateStateProvider.notifier).setDate(mySchedule);
      ref.read(startTimeStateProvider.notifier).setStart(myStartDate);
      ref.read(finishTimeStateProvider.notifier).setStart(myEndDate);
    });
  }
}
