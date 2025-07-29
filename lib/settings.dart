import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: const Text('Settings')
     ),
       body: Padding(
         padding: const EdgeInsets.all(20),
           child: ListView(
             children: [
               ElevatedButton(onPressed: (){
                 Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const ProfilePage()),
                 );
               },
                   child: Text('Edit Profile',
               textAlign: TextAlign.center,)
               ),
               const SizedBox(height: 20,),
               ElevatedButton(onPressed: () async{
                 await context.read<ThemeProvider>().toggleTheme();
               },
                   child: const Text('Switch Theme',
                     textAlign: TextAlign.center,),
               )
             ],
           ),
       ),
   );


  }

}