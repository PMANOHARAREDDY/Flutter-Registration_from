import 'package:flutter/material.dart';

// in-memory data Storage i.e in a map
Map<String, List<String>> userDetails = {};

class LoggedInUser {
  static final LoggedInUser _instance = LoggedInUser._internal();
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? password;
  LoggedInUser._internal();

  factory LoggedInUser() {
    return _instance;
  }

  static LoggedInUser get instance => _instance;

  void setUser(String email, List<String> userData) {
    this.email = email;
    name = userData[0];
    mobile = userData[1];
    address = userData[2];
    password = userData[3];
  }

  void updateUser(String newName, String newMobile, String newAddress, String newPassword) {
    name = newName;
    mobile = newMobile;
    address = newAddress;
    password = newPassword;

    if (email != null && userDetails.containsKey(email)) {
      userDetails[email!] = [newName, newMobile, newAddress, password ?? ''];
    }
  }
}


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

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : Text('Registration Page'),
      ),
      drawer: Drawer(
        child: Container(
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
                leading: Icon(Icons.home, color: Colors.amberAccent,),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.amberAccent,),
                title: Text('Settings'),
                onTap: () {
                  print("Bear up with us.... Under Development");
                 },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.amberAccent,),
                title: Text('Help & Feedback'),
                onTap: () { 
                  print("Bear up with us.... Under Development");
                },
              ),
            ]
          ),
        ),
      ), // AppBar
      body : Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children : [
              const Text('Name'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Name',
                ), 
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Email'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ), 
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Mobile'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone Number',
                ), 
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Address'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your address',
                ), 
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('password'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ), 
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Confirm password'),
              const SizedBox(
                height:5
              ),
              TextField(
                controller : confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password again',
                ), 
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){
                  
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String mobile = mobileController.text.trim();
                  String address = addressController.text.trim();
                  String password = passwordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();

                  if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty || mobile.isEmpty || name.isEmpty || address.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all the fields')),
                    );
                    return;
                  }

                  if(password != confirmPassword){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords are not matching')),
                    );
                    return;
                  }

                  if(userDetails.containsKey(email)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('This email is already registered with us try logging in'))
                    );
                    return;
                  }

                  userDetails[email] = [name, mobile, address, password];
                  print('User Registered: $email -> ${userDetails[email]}');

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }, 
                child: Text('Register'),
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
              ),
            ],
          ),
        ),
      ), 
    ); 
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      drawer: Drawer(
        child: Container(
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
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.amberAccent,),
                title: const Text('Register'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.amberAccent,),
                title: Text('Settings'),
                onTap: () {
                  print("Bear up with us.... Under Development");
                 },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.amberAccent,),
                title: Text('Help & Feedback'),
                onTap: () { 
                  print("Bear up with us.... Under Development");
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Email'),
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
              const Text('Password'),
              const SizedBox(height: 5),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
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
                onPressed: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (!userDetails.containsKey(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not found')),
                    );
                    emailController.clear();
                    passwordController.clear();
                    return;
                  }

                  if (userDetails[email]![3] == password) {
                    // Save to singleton
                    LoggedInUser user = LoggedInUser();
                    user.email = email;
                    user.name = userDetails[email]![0];
                    user.mobile = userDetails[email]![1];
                    user.address = userDetails[email]![2];
                    user.password = password;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuccessPage(email: email)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password not matched')),
                    );
                    passwordController.clear();
                  }
                },
                child: const Text(
                  'Sign In',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SuccessPage extends StatelessWidget {
  final String email;

  const SuccessPage({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    final user = LoggedInUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  'Welcome ${user.name}',
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.amberAccent,),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.amberAccent,),
                title: Text('Logout'),
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.amberAccent,),
                title: Text('Settings'),
                onTap: () {
                  print("Bear up with us.... Under Development");
                 },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.amberAccent,),
                title: Text('Help & Feedback'),
                onTap: () { 
                  print("Bear up with us.... Under Development");
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Log-in Successful! Welcome ${user.name}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}


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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: user.name);
    mobileController = TextEditingController(text: user.mobile);
    addressController = TextEditingController(text: user.address);
    passwordController = TextEditingController(text: user.password);
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void saveChanges() {
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

    // Update singleton and map
    user.updateUser(newName, newMobile, newAddress, newPassword);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );

    setState(() {}); // To refresh the view if needed
  }

  @override
  Widget build(BuildContext context) {
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
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
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



class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optimum Sync'),
      ),

      drawer: Drawer(
        child: Container(
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
                leading: Icon(Icons.person_add, color: Colors.amberAccent,),
                title: Text('Register'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.login, color: Colors.amberAccent,),
                title: Text('Login'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.amberAccent,),
                title: Text('Settings'),
                onTap: () {
                  print("Bear up with us.... Under Development");
                 },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.amberAccent,),
                title: Text('Help & Feedback'),
                onTap: () { 
                  print("Bear up with us.... Under Development");
                },
              ),
            ]
          ),
        ),
      ),

      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/OSLogo.png',
                  height : 100,
                ),
                SizedBox(
                  height: 20,
                ),
              Text(
                'Welcome to Optimum Sync',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}