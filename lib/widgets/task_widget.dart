import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_app/model/task_model.dart';
import 'package:todolist_app/services/theme.dart';

class TaskWidget extends StatelessWidget {
   TaskModel task;
  TaskWidget(this.task);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 0),
      width: MediaQuery.of(context).size.width,
      margin:const EdgeInsets.only(bottom: 12),
      child: Container(
      
        padding:const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGCLR(task.color ??0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              task.title.toString(),
              style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 18),
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey[100],
                  size: 21,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "${task.startTime.toString()} - ${task.endTime.toString()}",

                
                 
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100])),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              task.date.toString(),
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey[200],
              )),
            ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            width: 1.8,
            color: Colors.grey[200]!.withOpacity(0.8),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Column(
              children: [
                  task.isCompleted == 1?
                CircleAvatar(child: Icon(Icons.done_rounded,size: 25,color: Colors.white,),
                radius: 16,
                backgroundColor: Colors.greenAccent,)
             :  Container(),

                Text(
                  task.isCompleted == 1 ? "COMPLETED": "TODO",
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _getBGCLR(int no) {
    switch (no) {
      case 0:
        return Colors.blueGrey;
      case 1:
        return Colors.blue.shade600;

      case 2:
        return Colors.redAccent;
        case 3:
        return Colors.yellow.shade900;
        default:return DefoultColor.MyColor0;
    }
  }
}
