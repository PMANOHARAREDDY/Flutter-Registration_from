import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_)=> ThemeProvider(),
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Optimum Sync',
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff90d7ff),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffc9f9ff),
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffc9f9ff),
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffc9f9ff)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Color(0xffc9f9ff) , width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintStyle: TextStyle(color: Colors.black),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.black, fontSize: 16
          ),
          titleLarge: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24
          ),
          titleSmall: TextStyle(
              color: Colors.black26
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xffc9f9ff),
          surfaceTintColor: Colors.grey,
          scrimColor: Colors.black26,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
      ),

      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xff644160),
        appBarTheme: AppBarTheme(                   
          backgroundColor: Color(0xff917cab),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( 
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff917cab),
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
            borderSide: BorderSide(color: Color(0xff917cab)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff917cab), width: 2),
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
          backgroundColor: Color(0xff917cab),
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