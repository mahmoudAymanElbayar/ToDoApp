import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/shared/app_cubit/app_cupit.dart';
import 'package:todo_app/shared/app_cubit/app_states.dart';

class TodoScreens extends StatelessWidget {
  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..onCreat(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is InsertDataAppState) {
            Navigator.pop(context);
            taskController.text = '';
            timeController.text = '';
            dateController.text = '';
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  cubit.appTitle[cubit.cerrentScreen],
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  /*  try{
                var name = await getName();
                print('${name.toString()}');
                print('mahmoud');
                throw('erroooor !!!!!!!!');
              }
              catch(error){
                print('the error is '+error.toString());
              };
             */
                  // var name = await getName();
                  // print(
                  //   name
                  //     // await  getName()
                  // );
                  // getName().then((value) {
                  //   print(value);
                  //   print('mahmoud');
                  //   // throw('make an error');
                  // }
                  // ).catchError((error){
                  //   print('${error}');
                  // });
                  if (cubit.bottomSheetIsShow) {
                    if (formKey.currentState!.validate()) {
                      cubit.insert(
                          title: taskController.text,
                          time: timeController.text,
                          date: dateController.text);
                      // insert( title: taskController.text,
                      //   date: dateController.text,
                      //   time: timeController.text,).then((value) {
                      //   Navigator.pop(context);
                      //   bottomSheetIsShow = false;
                      //   // setState(() {
                      //   //   floatIcon = Icons.edit;
                      //   // });
                      // });
                    }
                  } else {
                    cubit.changeBottomSheetState(
                        isShow: true,
                        icon: Icons.add
                    );
                    scaffoldKey.currentState!.showBottomSheet(
                            (context) => Container(
                              color: Colors.white,
                              padding: EdgeInsetsDirectional.all(20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defultTextfeild(
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'text can\'t be empity';
                                          }
                                          return null;
                                            },
                                        controller: taskController,
                                        inputType: TextInputType.text,
                                        lableText: 'task name',
                                        prefixicon: Icons.title),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        defultTextfeild(
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'time can\'t be empity';
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              showTimePicker(context: context, initialTime: TimeOfDay.now(),
                                              ).then((value) {
                                                timeController.text = value!.format(context).toString();
                                              });
                                            },
                                            controller: timeController,
                                            inputType: TextInputType.datetime,
                                            lableText: 'time',
                                            prefixicon:
                                                Icons.watch_later_outlined),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        defultTextfeild(
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'date must not be empity';
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              showDatePicker(
                                                  context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse('2022-12-30')).then((value) {
                                                dateController.text = DateFormat.yMMMd().format(value!).toString();
                                              });
                                            },
                                            controller: dateController,
                                            inputType: TextInputType.datetime,
                                            lableText: 'date',
                                            prefixicon: Icons.calendar_today),
                                      ],
                                    ),
                                  ),
                                ),
                            elevation: 20).closed.then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false,
                          icon: Icons.edit);
                      //bottomSheetIsShow= false;
                      // setState(() {
                      //   floatIcon= Icons.edit;
                      // });
                    });

                    // bottomSheetIsShow = true;
                    // setState(() {
                    //   floatIcon= Icons.add;
                    // });
                  }
                  //insert();
                },
                child: Icon(cubit.floatIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.cerrentScreen,
                onTap: (index) {
                  // setState(() {
                  //    cerrentScreen = index ;
                  // });
                  cubit.changeScreen(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Task'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archive'),
                ],
              ),
              body: state != LoadingGetDataAppState
                  ? cubit.listScreen[cubit.cerrentScreen]
                  : Center(child: CircularProgressIndicator())

              );
        },
      ),
    );
  }
//Instance of 'Future<String>'
/* Future<String> getName() async
 {
    return 'mahmoudAyman';
 }

  */
// void creatDatabase () async
// {
//    var database = await openDatabase(
//      'todo.db',
//      version: 1,
//
//      onCreate: (database,version) async
//      {
//        try{
//          print('created database');
//          await database.execute(
//              'CREATE TABLE tasks( id INTEGER PRIMARY KEY , title TEXT , date TEXT ,time TEXT , status TEXT)');
//               print ('created table');
//        }catch(error){
//          print('${error.toString()}');
//        }
//
//      },
//      onOpen: (database){
//      print('opend database');
//      },
//    );
// }

}
