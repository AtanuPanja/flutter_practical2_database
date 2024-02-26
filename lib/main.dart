import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './UserList.dart';

void main() async{

  // initialize the hive database
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('userBox');
  // this userBox can now be referenced from any page in the application

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserList(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.yellow.shade200,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
    );
  }
}
