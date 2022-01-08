import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/medules/archive_screen/archive_screen.dart';
import 'package:todo_app/medules/done_screen/donescreen.dart';
import 'package:todo_app/medules/task_screen/task_screen.dart';
import 'package:todo_app/shared/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  int cerrentScreen =0 ;
  List<Widget> listScreen =[
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen()
  ];
 // IconData nn = MdiIcons.menu;
  IconData m = Icons.menu;
  List<String> appTitle = [
    'Task',
    'Done',
    'Archive'
  ];
  void changeScreen(int index){
    cerrentScreen = index;
    emit(BottomNavBarState());
  }
  ////////////////////////
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  void onCreat ()
  {
     openDatabase('toodoo.db',
        version: 1,
        onCreate: ( database ,version){
          database.execute('CREATE TABLE task(id INTEGER PRIMARY KEY , title TEXT , date TEXT ,time TEXT , status TEXT)').then((value) {
            print('table created');
          }).catchError((onError){
            print("the error is ${onError.toString()}");
          });
        },
        onOpen: (database){
          print('database opend');
          getData(database);
        }
    ).then((value) {
      database = value;
      emit(OnCreateDataAppState());
     });
  }
    insert({
      required String title,
      required String date,
      required String time,

  }) async
    {
      await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO task(title,date,time,status) VALUES ("$title","$date","$time", "new")'
      ).then((value){
        print('$value is added');
        emit(InsertDataAppState());
        getData(database);
      }).catchError((onError){
        print('the erroe is${onError.toString()}');
      });
    });

      // getData(database).then((value) {
      //   tasks = value;
      //   print(tasks);
      //   emit(GetDataAppState());
      // });
  }
  void getData(database) {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(LoadingGetDataAppState());
     database.rawQuery('SELECT * FROM task').then((value) {
       print(value);
       value.forEach((element) {
         print('${element['status']}');
         if(element['status'] == 'new')
           newTasks.add(element);
         else if(element['status']== 'done')
           doneTasks.add(element);
         else
           archiveTasks.add(element);
       });
       emit(GetDataAppState());
     });
  }
  bool bottomSheetIsShow = false;
  IconData floatIcon = Icons.edit;
  void changeBottomSheetState({
  required bool isShow,
    required IconData icon,
}){
    bottomSheetIsShow = isShow;
     floatIcon = icon;
    emit(ChangeIconBottomNavBarState());
  }
  void ubdatedata({
  required String status,
    required int id
  }){
    database.rawUpdate(
    'UPDATE task SET status = ? WHERE id = ?',
    ['$status','$id']).then((value) {
      getData(database);
      emit(UbdateDataAppState());

    });
  }
  void deleteData({
  required int id
}){
    database.rawDelete('DELETE FROM task WHERE id = ?', [id]);
    getData(database);
    emit(DeleteDataAppState());
  }
}

















void snackar (BuildContext context , String msg){
  var snack = SnackBar(content: Text("$msg"),
    action: SnackBarAction(label: 'Undo',
      onPressed: (){
        onclic(context);
      },),
  );
  Scaffold.of(context).showSnackBar(snack);
}
void onclic(BuildContext context){
  AlertDialog alertDialog = AlertDialog(
    title: Text("mahmoud"),
    content: Text("ayman"),
  );
  showDialog(
      context: context ,
      builder: (BuildContext context){
        return alertDialog;
      });
}