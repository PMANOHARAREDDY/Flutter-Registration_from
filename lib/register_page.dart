import 'package:flutter/material.dart';
import 'package:flutter_application_2/help.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'db_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dOBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('Registration Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text(
                'Optimum Sync',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.amberAccent,),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.amberAccent,),
              title: const Text('Help & Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Help()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Name*'),
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Name',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Email*'),
              const SizedBox(height: 5),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Date of Birth*'),
              const SizedBox(height: 5),
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

              const SizedBox(height: 10),
              const Text('Mobile*'),
              const SizedBox(height: 5),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone Number',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Address'),
              const SizedBox(height: 5),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your address',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Password*'),
              const SizedBox(height: 5),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Confirm password*'),
              const SizedBox(height: 5),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password again',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String mobile = mobileController.text.trim();
                  String address = addressController.text.trim();
                  String password = passwordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();
                  String dob = dOBController.text.trim();

                  if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty ||
                      mobile.isEmpty || name.isEmpty || dob.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all the fields')),
                    );
                    return;
                  }

                  final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if(!emailRegEx.hasMatch(email)){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter valid email address'))
                    );
                    return;
                  }

                  final passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

                  if (!passwordRegEx.hasMatch(password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password must have:\n'
                              '- At least 8 characters\n'
                              '- 1 uppercase letter\n'
                              '- 1 number\n'
                              '- 1 special character',
                        ),
                        duration: Duration(seconds: 4),
                      ),
                    );
                    return;
                  }


                  final phoneRegEx = RegExp(r'^[6-9]\d{9}$');

                  if (!phoneRegEx.hasMatch(mobile)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid 10-digit phone number'),
                      ),
                    );
                    return;
                  }

                  // Use SQLite
                  bool exists = await DBHelper.instance.userExists(email);
                  if (exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('This email is already registered, try logging in'))
                    );
                    return;
                  }

                  await DBHelper.instance.insertUser({
                    'email': email,
                    'name': name,
                    'mobile': mobile,
                    'address': address,
                    'password': password,
                    'date_of_birth': dob
                  });

                  print('User Registered: $email -> $name, $mobile, $address');
                  // Optionally clear fields here

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
