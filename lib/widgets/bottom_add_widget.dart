
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todolist_app/services/theme.dart';

bottomAddWidget({
Function()?fun,
required String titel,

}){
  return 
  InkWell(
          onTap: fun,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(top: 15),
            width: 120,
            decoration: BoxDecoration(
                color: DefoultColor.MyColor0,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                titel,
                style: TextStyle(
                    fontFamily: 'Acme',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? Colors.white : Colors.white),
              ),
            ),
          ),
        );
   
}
      