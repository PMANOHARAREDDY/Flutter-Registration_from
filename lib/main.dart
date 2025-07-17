import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.purple,      
        appBarTheme: AppBarTheme(                   
          backgroundColor: Color.fromARGB(255, 78, 25, 169),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( 
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 78, 25, 169),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(   
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 78, 25, 169)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 78, 25, 169), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        textTheme: const TextTheme(         
          bodyMedium: TextStyle(
            color: Colors.white, fontSize: 16
          ),
          titleLarge: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24
          ),
          titleSmall: TextStyle(
            color: Colors.white70
          ),
        ),
        drawerTheme: DrawerThemeData(                  
          backgroundColor: Color.fromARGB(255, 78, 25, 169),
          surfaceTintColor: Colors.transparent,
          scrimColor: Colors.black54,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}