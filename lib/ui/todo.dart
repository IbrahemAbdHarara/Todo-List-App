import 'dart:ui';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/controllers/task_controllers.dart';
import 'package:todolist_app/model/task_model.dart';
import 'package:todolist_app/services/theme.dart';
import 'package:todolist_app/services/themeService.dart';
import 'package:todolist_app/ui/addTaskPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todolist_app/widgets/bottom_add_widget.dart';
import 'package:todolist_app/widgets/bottom_widget.dart';
import 'package:todolist_app/widgets/task_widget.dart';

class Todolist_app extends StatefulWidget {
  @override
  State<Todolist_app> createState() => _Todolist_appState();
}

class _Todolist_appState extends State<Todolist_app> {
  TaskContoller taskContoller = Get.put(TaskContoller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:Get.isDarkMode?Colors.grey.shade900: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
      backgroundColor:Get.isDarkMode?Colors.grey.shade900: context.theme.backgroundColor,
        leading: InkWell(
            onTap: () {
              ThemeService().swithTeme();
            },
            child: Icon(
              Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nights_stay_outlined,
              size: 35,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Today',
              style: headingStyle,
            )
          ],
        ),
        Spacer(),
        bottomAddWidget(
            titel: '+ Add Task',
            fun: () async {
              await Get.to(() => AddTaskPage());
            })
      ],
    );
  }

  _addDateBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: GetBuilder<TaskContoller>(builder: (context) {
        return DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectedTextColor: Colors.white,
          selectionColor:DefoultColor.MyColor0,
          dateTextStyle: GoogleFonts.acme(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Get.isDarkMode ? Colors.white : Colors.grey),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.grey),
          ),
          monthTextStyle: GoogleFonts.laila(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.grey),
          ),
          onDateChange: (date) {
            setState(() {
              taskContoller.onDateChange(date);
            });
          },
        );
      }),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
            itemBuilder: (_, index) {
              TaskModel taskModel = taskContoller.taskList[index];

              print(taskModel.toMap());
              print(taskModel.date);
              if (taskModel.repeat == 'Daily') {
                 
                return AnimationConfiguration.staggeredList(
                  delay: Duration(milliseconds: 5),
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                    child: InkWell(
                      onTap: () {
                        // taskContoller.delete(taskContoller.taskList[index]);
                        _showBottomSheet(context, taskModel);
                      },
                      child: TaskWidget(taskModel),
                    ),
                  )),
                );
              } else if (taskModel.date ==
                  DateFormat.yMd().format(taskContoller.selectDateTime)) {
                    taskContoller.colordate=true;
              return     
                 AnimationConfiguration.staggeredList(

                  delay: Duration(milliseconds: 5),
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                    child: InkWell(
                      onTap: () {
                        // taskContoller.delete(taskContoller.taskList[index]);
                        _showBottomSheet(context, taskModel);
                      },
                      child: TaskWidget(taskModel),
                    ),
                  )),
                );
                
        
         
    
              }
              return Container();
            },
            itemCount: taskContoller.taskList.length);
      },
    ));
  }

  _showBottomSheet(BuildContext context, TaskModel taskModel) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: taskModel.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Get.isDarkMode ? Colors.white70 : Colors.white70,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[700] : Colors.white,
              ),
              height: 4,
              width: 120,
            ),
            taskModel.isCompleted == 1
                ? Container()
                : BottomWidget(
                    name: 'Task Completed',
                    color: Colors.greenAccent,
                    function: () {
                      taskContoller.taskCompleted(taskModel.id!);

                      Get.back();
                    },
                    context: context,
                  ),
            BottomWidget(
              name: 'Delete Task',
              color: Colors.redAccent,
              function: () {
                taskContoller.delete(taskModel);
                Get.back();
              },
              context: context,
            ),
            SizedBox(
              height: 20,
            ),
            BottomWidget(
              name: 'Close',
              color: Colors.white,
              function: () {
                Get.back();
              },
              isclose: true,
              context: context,
            ),
          ],
        )));
  }
}
