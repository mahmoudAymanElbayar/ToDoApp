import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/shared/app_cubit/app_cupit.dart';
import 'package:todo_app/shared/app_cubit/app_states.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*ListView.separated(
        itemBuilder: (context,index)=>itemOfListBuilder(tasks[index]),
        separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          color: Colors.grey,
          height: 1.0,
        ),
        itemCount: tasks.length);*/
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return  archiveScreen(tasks: tasks);
      },
    );
      // ListView.separated(
      //   itemBuilder: (context,index)=>itemOfListBuilder(tasks[index]),
      //   separatorBuilder: (context,index)=>Container(
      //     height: 1,
      //     width: double.infinity,
      //     color: Colors.grey,
      //   ),
      //   itemCount: tasks.length);
  }
}
