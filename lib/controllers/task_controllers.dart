import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/db/db_helper.dart';
import 'package:todolist_app/model/task_model.dart';

class TaskContoller extends GetxController {
  TaskContoller() {
    getAllTasks();
  }
  @override
  void onReady() {
    super.onReady();
  }

  final GlobalKey globalKey = GlobalKey();
  final TextEditingController titelController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool colordate = false;
  String endTime = "7:57 PM";
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  DateTime selectDateTime = DateTime.now();
  int selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String selectRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];
  int selectColor = 0;
  var taskList = <TaskModel>[].obs;
  validateDate() async {
    if (titelController.text.isNotEmpty && noteController.text.isNotEmpty) {
      await addTaskToDb();
      getAllTasks();
      update();
//So add in database
      Get.back();
    } else if (titelController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'Required', 'All Fielde Are Required !',
        duration: Duration(seconds: 5),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        //  backgroundColor: Colors.white70,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        titleText: Text(
          'Required',
          style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.red)),
        ),
        messageText: Text(
          'All Fielde Are Required !',
          style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent)),
        ),
        icon: const Icon(
          Icons.warning_amber_rounded,
          size: 35,
          color: Colors.redAccent,
        ),
        mainButton: TextButton(
            clipBehavior: Clip.none,
            onPressed: () {
              Get.back();
            },
            child: Icon(
              Icons.dangerous_outlined,
              color: Colors.redAccent,
              size: 27,
            )),
      );
    }
    update();
  }

  addTaskToDb() async {
    TaskModel? taskModel;
    int value = await addTask(
      taskModel: TaskModel(
          title: titelController.text,
          note: noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectDateTime),
          startTime: startTime,
          endTime: endTime,
          color: selectColor,
          remind: selectRemind,
          repeat: selectRepeat),
    );
    update();
  }

  Future<int> addTask({TaskModel? taskModel}) async {
    return await DBHelper.insert(taskModel);
  }

  void getAllTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => TaskModel.fromMap(e)).toList());
    print(startTime);
    update();
  }

  void delete(TaskModel taskModel) {
    DBHelper.delete(taskModel);
    getAllTasks();
    update();
  }

  void taskCompleted(int id) async {
    await DBHelper.update(id);
    getAllTasks();
    update();
  }

  void onDateChange(DateTime dateTime) async {
    // selectDateTime
    update();
    selectDateTime = (dateTime);
  }
}
