import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'db_helper.dart';   
import 'logged_in_user.dart'; 

class SuccessPage extends StatefulWidget {
  final String email;

  const SuccessPage({super.key, required this.email});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final dbUser = await DBHelper.instance.getUser(widget.email);
    // Optionally update the singleton
    if (dbUser != null) {
      LoggedInUser.instance.setUser(
        dbUser['email'],
        [
          dbUser['name'],
          dbUser['mobile'],
          dbUser['address'],
          dbUser['password'],
        ],
      );
    }
    setState(() {
      user = dbUser; // may be null
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Success')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Optimum Sync',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.amberAccent,),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.amberAccent,),
              title: const Text('Logout'),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.amberAccent,),
              title: const Text('Settings'),
              onTap: () {
                print("Bear up with us.... Under Development");
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.amberAccent,),
              title: const Text('Help & Feedback'),
              onTap: () { 
                print("Bear up with us.... Under Development");
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Log-in Successful! Welcome ${user!['name'] ?? 'User'}',
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
