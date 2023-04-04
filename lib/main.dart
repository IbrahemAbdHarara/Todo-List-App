import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist_app/db/db_helper.dart';
import 'package:todolist_app/services/theme.dart';
import 'package:todolist_app/services/themeService.dart';
import 'package:todolist_app/ui/todo.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main()async {
  
WidgetsFlutterBinding.ensureInitialized();
await DBHelper.dbHelper.initDatabase();
await GetStorage.init();
  runApp(const MyApp());
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
   theme: Mytheme.light,
darkTheme: Mytheme.dark,
   themeMode:ThemeService().theme,
   
      home:Todolist_app(),
    );
    
  }

}
