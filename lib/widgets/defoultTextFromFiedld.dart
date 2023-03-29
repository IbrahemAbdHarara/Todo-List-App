
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:todolist_app/services/theme.dart';

class defoultTextFormField extends StatelessWidget {
    final Function? validator;

  final Widget? widget; 
  final String?initialValue;

  final String titel;
  final String? hintText;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  defoultTextFormField(
      {required this.hintText,
    this.initialValue,
      this.widget,
      required this.titel,
       this.textEditingController,
      required this.validator,
       this.textInputType});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titel,
            style: titleStyle,
          ),
          Container(
            height: 53,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
             
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue:initialValue ,
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: textEditingController,
                    validator: (value) {
                      return validator!(value!);
                    },
                    style: textstyle,
                    keyboardType: textInputType,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: hintText,
                      hintStyle: hintStyle,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor,
                              width: 0.0)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor, width: 0)),
                    ),
                  ),
                ),
             widget==null?Container():Container(child: widget,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
