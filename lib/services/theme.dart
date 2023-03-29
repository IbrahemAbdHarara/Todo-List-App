
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 class DefoultColor{
static const  Color MyColor0=Colors.blueGrey;
static  Color MyColor1=Colors.blue.shade600;
static  Color MyColor2= Colors.redAccent;
static  Color MyColor3=Colors.yellow.shade900;

 }
class Mytheme{

static final light= ThemeData(
     backgroundColor: Colors.white,

  primaryColor: Colors.purple.shade100,
   brightness:Brightness.light,
   );
   static final dark =  ThemeData(
       backgroundColor: Colors.black87,

primaryColor: ( Colors.purple.shade900),

   brightness:Brightness.dark);
  
}

TextStyle get subHeadingStyle{
  return   GoogleFonts.lato(
    textStyle:    
  TextStyle(
       
fontSize: 24,
fontWeight: FontWeight.w700
,
color: Get.isDarkMode?Colors.grey.shade200:Colors.grey.shade500
  ),
 
  ); 
  
 
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle:
    TextStyle(fontSize: 21,
fontWeight: FontWeight.w900,
color: Get.isDarkMode?Colors.white:Colors.black87
)
     ,
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle:
    TextStyle(fontSize: 18,
fontWeight: FontWeight.w700,
color: Get.isDarkMode?Colors.white:Colors.black
)
     ,
  );
}

TextStyle get hintStyle{
  return GoogleFonts.lato(
    textStyle:
    TextStyle(fontSize:   16,
fontWeight: FontWeight.w400,
color: Get.isDarkMode?Colors.grey[100]:Colors.grey[700]
)
     ,
  );
}
TextStyle get textstyle{
  return GoogleFonts.lato(
    textStyle:
    TextStyle(fontSize:   16,
fontWeight: FontWeight.w700,
color: Get.isDarkMode?Colors.grey[200]:Colors.grey[900]
)
     ,
  );
}