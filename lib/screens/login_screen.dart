
import 'package:flutter/material.dart';
import 'package:project_final/extension/nav.dart';
import 'package:project_final/screens/home_screen.dart';
import 'package:project_final/screens/list_screen.dart';
import 'package:project_final/screens/signup_screen.dart';
import 'package:project_final/service/database.dart';
import 'package:project_final/widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    return Scaffold(
      backgroundColor: Colors.brown,
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
                  "Login",
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
                  onPressed: () async {
                    try {
                      await Database().login(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      if (context.mounted) {
                        context.pushAndDelete(HomeScreen());
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("login", style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                  onPressed: () async {
                    context.pushAndDelete(SignupScreen());
                  },
                  child: Text("don't have an account? signup", style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}