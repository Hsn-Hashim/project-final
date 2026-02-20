
import 'package:flutter/material.dart';
import 'package:project_final/extension/nav.dart';
import 'package:project_final/screens/login_screen.dart';
import 'package:project_final/service/database.dart';
import 'package:project_final/widget/text_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(backgroundColor: Colors.brown,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Container(
            
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "sign up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFieldWidget(
                  hint: "enter your email",
                  icon: Icon(Icons.email),
                  controller: emailController,
                ),
                TextFieldWidget(
                  hint: "enter your password",
                  icon: Icon(Icons.password),
                  controller: passwordController,
                  isObscure: true,
                ),
                ElevatedButton(
                  onPressed: () async{
                    await Database().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    context.pushAndDelete(LoginScreen());
                  },
                  child: Text("Sign up", style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                  onPressed: () {
                    context.pushAndDelete(LoginScreen());
                  },
                  child: Text("have an account? login", style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}