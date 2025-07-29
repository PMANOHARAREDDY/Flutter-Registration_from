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
  late TextEditingController dOBController;
  final TextEditingController confirmPasswordController = TextEditingController();


  bool loading = true;

  @override
  void initState() {
    super.initState();
    // Initially blank; will populate after DB fetch
    nameController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    dOBController = TextEditingController();
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
      dOBController.text = dbUser['date_of_birth'] ?? '';

      // Also update singleton for consistency
      user.setUser(user.email!, [
        dbUser['name'],
        dbUser['mobile'],
        dbUser['address'],
        dbUser['password'],
        dbUser['date_of_birth'],
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
    dOBController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    String newName = nameController.text.trim();
    String newMobile = mobileController.text.trim();
    String newAddress = addressController.text.trim();
    String newPassword = passwordController.text.trim();
    String newDOB = dOBController.text.trim();
    String newConfirmPassword = confirmPasswordController.text.trim();

    if (newName.isEmpty || newPassword.isEmpty || newDOB.isEmpty || newConfirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if(newPassword != newConfirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords are not matching try again')),
      );
      passwordController.clear();
      confirmPasswordController.clear();
      return;
    }

    if (!is18OrOlder(dOBController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be at least 18 years old to use this application')),
      );
      dOBController.clear();
      return;
    }

    // Update in SQLite
    await DBHelper.instance.updateUser({
      'email': user.email,
      'name': newName,
      'mobile': newMobile,
      'address': newAddress,
      'password': newPassword,
      'date_of_birth' : newDOB,
    });

    // Update singleton
    user.updateUser(newName, newMobile, newAddress, newPassword, newDOB);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );

    setState(() {}); // Optional, to refresh if needed
  }

  bool is18OrOlder(String dobStr) {
    try {
      List<String> parts = dobStr.split('/');
      if (parts.length != 3) return false;
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      DateTime dob = DateTime(year, month, day);
      DateTime today = DateTime.now();

      int age = today.year - dob.year;
      if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      return age >= 18;
    } 
    catch (e) {
      return false;
    }
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
            const SizedBox(height: 10),
            const Text('Name*'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Phone Number'),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText : 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            const Text('Date of Birth*'),
            TextField(
              controller: dOBController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select your Date of Birth',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                String formattedDate = "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";
                setState(() {
                  dOBController.text = formattedDate;
                });
              },
            ),
            const SizedBox(height: 15),
            const Text('Address'),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Password*'),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password*',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
              const Text('Confirm password*'),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password again',
                ),
              ),
            const SizedBox(height: 20),
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
