import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme.dart';
import 'package:provider/provider.dart';


class SettingsWel extends StatefulWidget {
  const SettingsWel({super.key});

  @override
  State<SettingsWel> createState() => _SettingsWelState();
}

class _SettingsWelState extends State<SettingsWel>{

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