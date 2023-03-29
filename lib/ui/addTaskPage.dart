import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/controllers/task_controllers.dart';
import 'package:todolist_app/model/task_model.dart';
import 'package:todolist_app/widgets/bottom_add_widget.dart';
import 'package:todolist_app/widgets/defoultTextFromFiedld.dart';
import 'package:todolist_app/services/theme.dart';
import 'package:todolist_app/ui/todo.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskContoller = Get.put(TaskContoller());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:Get.isDarkMode?Colors.grey.shade900: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: taskContoller.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add Task New',
                    style: headingStyle,
                  ),
                  defoultTextFormField(
                      titel: 'Titel',
                      hintText: 'Enter your title here.',
                      textEditingController: taskContoller.titelController,
                      validator: () {},
                      textInputType: TextInputType.text),
                  defoultTextFormField(
                      titel: 'Note',
                      hintText: 'Enter your note here.',
                      textEditingController: taskContoller.noteController,
                      validator: () {},
                      textInputType: TextInputType.text),
                  defoultTextFormField(
                    titel: 'Date',
                    hintText:
                        '${DateFormat.yMd().format(taskContoller.selectDateTime)}',
                    validator: () {
                      // DateFormat.MMM()
                    },
                    textInputType: TextInputType.text,
                    widget: IconButton(
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 27,
                      ),
                      onPressed: () {
                        _getDateFromUser();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: defoultTextFormField(
                        hintText: taskContoller.startTime,
                        titel: 'Start Time',
                        validator: () {},
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time,
                            size: 27,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isstartTime: true);
                          },
                        ),
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: defoultTextFormField(
                        hintText: taskContoller.endTime,
                        titel: 'End Time',
                        validator: () {},
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time,
                            size: 27,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isstartTime: false);
                          },
                        ),
                      ))
                    ],
                  ),
                  defoultTextFormField(
                    hintText: '${taskContoller.selectRemind} minutes early',
                    titel: 'Remind',
                    validator: () {},
                    widget: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: Get.isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[100],
                        onTap: () {},
                        onChanged: (value) {
                          setState(() {
                            taskContoller.selectRemind = int.parse(value!);
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                        elevation: 4,
                        style: textstyle,
                        underline: Container(height: 0),
                        items: taskContoller.remindList
                            .map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.grey[700])),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  defoultTextFormField(
                    hintText: taskContoller.selectRepeat,
                    titel: 'Repeat',
                    validator: () {},
                    widget: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: Get.isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[100],
                        onTap: () {},
                        onChanged: (String? value) {
                          setState(() {
                            taskContoller.selectRepeat = (value!);
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                        elevation: 4,
                        style: textstyle,
                        underline: Container(height: 0),
                        items: taskContoller.repeatList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.grey[700]),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Color',
                            style: titleStyle,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Wrap(
                              children: List<Widget>.generate(4, (int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  taskContoller.selectColor = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: index == 0
                                      ? DefoultColor.MyColor0
                                      : index == 1
                                          ? DefoultColor.MyColor1
                                          : index == 2
                                              ? DefoultColor.MyColor2
                                              : DefoultColor.MyColor3,
                                  child: taskContoller.selectColor == index
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          })),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 10,),
                    bottomAddWidget(titel: 'Create Task',fun: (){
                      taskContoller.validateDate();
                    })
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      
      elevation: 0,
      backgroundColor:Get.isDarkMode?Colors.grey.shade900: context.theme.backgroundColor,
      iconTheme: context.theme.iconTheme,
    );
  }

  _getDateFromUser() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _pikerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2323),
    );
    if (_pikerDate != null) {
      setState(() {
        taskContoller.selectDateTime = _pikerDate;
      });
    } else {
      print("it's null or worng");
    }
  }

  _getTimeFromUser({required bool isstartTime}) async {
    var _pikeTime = await _showTimePicker();
    if (_pikeTime == null) {
      print('not contect time obsee');
    } else if (_pikeTime != null) {
      String _formatTime = _pikeTime.format(context);

      if (isstartTime == true) {
        setState(() {
          taskContoller.startTime = _formatTime;
        });
      } else if (isstartTime == false) {
        setState(() {
          taskContoller.endTime = _formatTime;
        });
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            //debug is 8:2 PM
            hour: int.parse(taskContoller.startTime.split(":")[0]),
            minute: int.parse(
                taskContoller.startTime.split(":")[1].split(" ")[0])));
  }

  _validateDate() {
    if (taskContoller.titelController.text.isNotEmpty &&
        taskContoller.noteController.text.isNotEmpty) {
      _addTaskToDb();
//So add in database
      Get.back();
    } else if (taskContoller.titelController.text.isEmpty ||
        taskContoller.noteController.text.isEmpty) {
      Get.snackbar(
        'Required', 'All Fielde Are Required !',
        duration: Duration(seconds: 5),
margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
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
    print(taskContoller.startTime);
  }

  _addTaskToDb() async {
    TaskModel? taskModel;
    int value = await taskContoller.addTask(
      taskModel: TaskModel(
          title: taskContoller.titelController.text,
          note: taskContoller.noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(taskContoller.selectDateTime),
          startTime: taskContoller.startTime,
          endTime: taskContoller.endTime,
          color: taskContoller.selectColor,
          remind: taskContoller.selectRemind,
          repeat: taskContoller.selectRepeat),
    );
  }
}
