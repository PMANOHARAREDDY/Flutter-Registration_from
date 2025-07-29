import 'package:flutter/material.dart';

import 'db_helper.dart';

class Help extends StatefulWidget{
  const Help({super.key});

  @override
  State<Help> createState() => _HelpPageState();

}

class _HelpPageState extends  State<Help>{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  String? easeOfUse;
  Future<void> submitFeedback() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Feedback'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text('Name*'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name'
              ),
            ),
            const SizedBox(height: 15),
            const Text('Email*'),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 15),
            const Text('Ease of Use*'),
            DropdownButtonFormField<String>(
              value: easeOfUse,
              items: const[
                DropdownMenuItem(value: 'Easy',child: Text('Easy'),),
                DropdownMenuItem(value:'Moderate',child: Text('Moderate')),
                DropdownMenuItem(value:'Could be better',child: Text('Could be better'))
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('Select an option'),
              onChanged: (value){
                if(value!=null){
                  setState(() => easeOfUse = value);
                }
              },
            ),
            const SizedBox(height: 15,),
            const Text('Your feedback'),
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your feedback and suggestions here'
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              final name = nameController.text.trim();
              final email = emailController.text.trim();
              final comment = commentController.text.trim();
              
              if(name.isEmpty || email.isEmpty || easeOfUse == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all the required fields')),
                );
                return;
              }
      
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
              if (!emailRegex.hasMatch(email)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid email')),
                );
                return;
              }

              print("Under Development, Bear up with us until next version's release");
              print("!!!!....Help & Feedback Retrieved....!!!!");
              print(name);
              print(email);
              print(easeOfUse);
              print(comment);

              await DBHelper.instance.insertFeedback(
                  {
                'name': name,
                'email': email,
                'ease_of_use': easeOfUse,
                'comment': comment,
              }
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback submitted successfully!')),
              );
      
              nameController.clear();
              emailController.clear();
              commentController.clear();
              setState(() => easeOfUse = null);
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
                child: const Text('Submit Feedback')
            )
          ],
        ),
      ),
    );
  }
}