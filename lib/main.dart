import 'package:flutter/material.dart';

// in-memory data Storage i.e in a map
Map<String, List<String>> userDetails = {};

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 82, 36, 162)),
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
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
        backgroundColor: Color.fromARGB(255, 78, 25, 169),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.purple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Optimum Sync',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
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
                  hintText: 'Enter your phone Number please',
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
                child: Text('Register',
                style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ), // ListView
    ); // Scaffold
  }
}

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  // Create Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : Text('Login Page'),
        backgroundColor: Color.fromARGB(255, 82, 36, 162),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.purple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Optimum Sync',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ]
          ),
        ),
      ),// AppBar
      body : Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children : [
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
                height: 25,
              ),

              ElevatedButton(
                onPressed: (){

                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if(!userDetails.containsKey(email)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not found'))
                    );
                    emailController.clear();
                    passwordController.clear();
                    return;
                  }

                  if(userDetails[email]![3]==password){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuccessPage(email: email)),
                    );
                  }
                  
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password not matched'))
                    );
                    passwordController.clear();
                    return;
                  }
                  
                }, 
                child: Text('sign in',
                style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ), // ListView
    ); // Scaffold
  }
}

class SuccessPage extends StatelessWidget {
  final String email;

  const SuccessPage({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
        backgroundColor: Color.fromARGB(255, 82, 36, 162),
      ),
      body: Center(
        child: Text(
          'Log-in Successful! welcome ${userDetails[email]![0]}',
          style: TextStyle(fontSize: 24),
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
        title: Text('OS'),
        backgroundColor: Color.fromARGB(255, 82, 36, 162),
      ),

      drawer: Drawer(
        child: Container(
          color: Colors.purple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Optimum Sync',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Register'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ]
          ),
        ),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text(
              'Welcome to Optimum Sync',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
          ),
        ),
      ),
    );
  }
}





