import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends ConsumerState<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
