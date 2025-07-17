import 'package:flutter/material.dart';
import 'logged_in_user.dart';
import 'db_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = LoggedInUser.instance;

  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController passwordController;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    // Initially blank; will populate after DB fetch
    nameController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    loadUserFromDb();
  }

  Future<void> loadUserFromDb() async {
    if (user.email == null) {
      setState(() => loading = false);
      return;
    }
    final dbUser = await DBHelper.instance.getUser(user.email!);
    if (dbUser != null) {
      nameController.text = dbUser['name'] ?? '';
      mobileController.text = dbUser['mobile'] ?? '';
      addressController.text = dbUser['address'] ?? '';
      passwordController.text = dbUser['password'] ?? '';

      // Also update singleton for consistency
      user.setUser(user.email!, [
        dbUser['name'],
        dbUser['mobile'],
        dbUser['address'],
        dbUser['password'],
      ]);
    }
    setState(() => loading = false);
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    String newName = nameController.text.trim();
    String newMobile = mobileController.text.trim();
    String newAddress = addressController.text.trim();
    String newPassword = passwordController.text.trim();

    if (newName.isEmpty || newMobile.isEmpty || newAddress.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Update in SQLite
    await DBHelper.instance.updateUser({
      'email': user.email,
      'name': newName,
      'mobile': newMobile,
      'address': newAddress,
      'password': newPassword,
    });

    // Update singleton
    user.updateUser(newName, newMobile, newAddress, newPassword);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );

    setState(() {}); // Optional, to refresh if needed
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Profile')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText : 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
