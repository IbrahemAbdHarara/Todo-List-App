

  import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todolist_app/services/theme.dart';

BottomWidget(
      {required String  name,
      required Color color,
  required  BuildContext context,
  bool isclose=false,
      required Function()? function,
        }){

      
  
    // TODO: implement build
    return InkWell(
      onTap:function,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isclose == true
                  ? Get.isDarkMode
                      ? Colors.grey[700]!
                      : Colors.white
                  : color),
          borderRadius: BorderRadius.circular(12),
          color: isclose == true ? Colors.transparent : color,
        ),
        child: Center(
            child: Text(
          name,
          style:isclose?titleStyle:titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

