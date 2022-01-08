import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/app_cubit/app_cupit.dart';

Widget defultButton({
  required VoidCallback function,
  required String text,
  double width = double.infinity,
  Color backgroundColor = Colors.lightBlueAccent,
  bool isUbberCase = true,
  double radius = 0,

  // required void Function() function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUbberCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

Widget defultTextfeild({
  required String? Function(String?) validate,
  required TextEditingController controller,
  required TextInputType inputType,
  required String lableText,
  required IconData prefixicon,
  VoidCallback? showpassword,
  IconData? suffex,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  bool isobscure = false,
  VoidCallback? onTap,
  Color? lableColor,
  Color? fillolor,
  Color? focuseColor,
  Color? hoverColors
}) =>
    TextFormField(
      controller: controller,
      obscureText: isobscure,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      keyboardType: inputType,
      decoration: InputDecoration(
        fillColor: fillolor,
        focusColor: focuseColor,
        hoverColor: hoverColors,
        labelText: lableText,
        labelStyle: TextStyle(color: lableColor),
        prefixIcon: Icon(prefixicon),
        suffix: suffex != null
            ? IconButton(onPressed: showpassword, icon: Icon(suffex))
            : null,
        border: OutlineInputBorder(),
      ),
    );
// (value){
// if(value!.isEmpty) {
// return 'email mest not be empty';
// };
// return null;
// },
Widget itemOfListBuilder(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                '${model['time']}',
              ),
              radius: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .ubdatedata(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_circle_outline),
              color: Colors.lightBlueAccent,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .ubdatedata(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive),
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget itemOfDoneListBuilder(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                '${model['time']}',
              ),
              radius: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     AppCubit.get(context)
            //         .ubdatedata(status: 'done', id: model['id']);
            //   },
            //   icon: Icon(Icons.check_circle_outline),
            //   color: Colors.lightBlueAccent,
            // ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .ubdatedata(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive),
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget itemOfArchiveListBuilder(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                '${model['time']}',
              ),
              radius: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .ubdatedata(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_circle_outline),
              color: Colors.lightBlueAccent,
            ),
            // IconButton(
            //   onPressed: () {
            //     AppCubit.get(context)
            //         .ubdatedata(status: 'archive', id: model['id']);
            //   },
            //   icon: Icon(Icons.archive),
            //   color: Colors.lightBlueAccent,
            // ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget taskScreen({required List<Map> tasks}) => tasks.length != 0
    ? ListView.separated(
        itemBuilder: (context, index) {
          return itemOfListBuilder(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 100, color: Colors.grey[400]),
            Text(
              'no tasks yet please enter your task',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            )
          ],
        ),
      );

Widget doneScreen({required List<Map> tasks}) => tasks.length != 0
    ? ListView.separated(
        itemBuilder: (context, index) {
          return itemOfDoneListBuilder(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 100, color: Colors.grey[400]),
            Text(
              'no tasks yet please enter your task',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            )
          ],
        ),
      );

Widget archiveScreen({required List<Map> tasks}) => tasks.length != 0
    ? ListView.separated(
        itemBuilder: (context, index) {
          return itemOfArchiveListBuilder(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 100, color: Colors.grey[400]),
            Text(
              'no tasks yet please enter your task',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            )
          ],
        ),
      );

Widget textFormFeild({
  required TextEditingController controller,
  VoidCallback? ontap,
  Function(String)? onchange,
  Function(String)? onsubmit,
  bool isObscure = false,
  required IconData prefix,
  required String lable,
  IconData? suffix,
  required TextInputType inputType,
  required String? Function(String?) validate,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      onTap: ontap,
      onChanged: onchange,
      onFieldSubmitted: onsubmit,
      obscureText: isObscure,
      keyboardType: inputType,
      decoration: InputDecoration(
          label: Text(lable),
          prefix: Icon(prefix),
          suffix: Icon(suffix),
          border: OutlineInputBorder()),
    );
/////////////////////////////////////////

Widget myLineSeperated()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

void goTO(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

