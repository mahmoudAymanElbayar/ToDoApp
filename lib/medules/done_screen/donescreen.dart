import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/shared/app_cubit/app_cupit.dart';
import 'package:todo_app/shared/app_cubit/app_states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return  doneScreen(tasks: tasks);
      },
    );
  }
}