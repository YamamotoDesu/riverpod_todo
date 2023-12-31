// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/custom_text.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';
import 'package:riverpod_todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/features/todo/widgets/day_after_tomorrow_tasks.dart';
import 'package:riverpod_todo/features/todo/widgets/tomorrow_list.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/width_spacer.dart';
import '../widgets/completed_task.dart';
import '../widgets/today_tasks.dart';
import 'add_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Dashboard",
                      style: appstyle(18, AppConst.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const AddTask();
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppConst.kBkDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HeightSpacer(
                height: 20,
              ),
              CustomTextField(
                hintText: "Search",
                controller: controller,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppConst.kGreyLight,
                ),
              ),
              const HeightSpacer(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const HeightSpacer(height: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConst.kLight,
                  ),
                  const WidthSpacer(wydth: 10),
                  ReusableText(
                    text: "Today's Task",
                    style: appstyle(
                      18,
                      AppConst.kLight,
                      FontWeight.bold,
                    ),
                  )
                ],
              ),
              const HeightSpacer(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: AppConst.kLight,
                  borderRadius: BorderRadius.circular(AppConst.kRadius),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.circular(AppConst.kRadius),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  unselectedLabelColor: AppConst.kBkLight,
                  labelStyle: appstyle(
                    24,
                    AppConst.kBlueLight,
                    FontWeight.w700,
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: AppConst.kWidth * 0.5,
                        child: ReusableText(
                          text: "Pending",
                          style: appstyle(
                            16,
                            AppConst.kBkDark,
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: AppConst.kWidth * 0.5,
                        child: ReusableText(
                          text: "Completed",
                          style: appstyle(
                            16,
                            AppConst.kBkDark,
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              SizedBox(
                height: AppConst.kHeight * 0.3,
                width: AppConst.kWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConst.kRadius),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHeight * 0.3,
                        child: const TodayTasks(),
                      ),
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHeight * 0.3,
                        child: const CompletedTasks(),
                      ),
                    ],
                  ),
                ),
              ),
              const HeightSpacer(
                height: 20,
              ),
              const TomorrowList(),
              const HeightSpacer(
                height: 20,
              ),
              const DayAfterList(),
              const HeightSpacer(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
