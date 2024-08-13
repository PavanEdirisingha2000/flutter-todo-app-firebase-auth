import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/home_screen.dart';
import 'package:to_do_app_flutter/services/auth_services.dart';
import 'package:to_do_app_flutter/signup.dart';

class LoginScreen extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      title: Text("Sign In"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Welcome back", style: TextStyle(color: Colors.white, fontSize: 30),),
              Text("LogIn Here", style: TextStyle(color: Colors.white, fontSize: 17),),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    
                  ),

                  ),
                
              SizedBox(height: 40),
              TextField(
                controller: _passController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    
                  ),

                  ),

                  SizedBox(height: 50),
                  SizedBox(height: 40,
                  width: MediaQuery.of(context).size.width/1.5,
                    child: ElevatedButton(
                      onPressed: () async {
                          User? user = await _auth.signInWithEmailAndPassword(
                            _emailController.text,
                            _passController.text,
                    
                    
                          );
                    
                          if (user != null) {
                            Navigator.push(context,MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                          } 
                          },
                          child: Text("LogIn",style: TextStyle
                          (color: Colors.indigo, fontSize: 18),),
                    
                    
                    
                    
                        ),
                  ),

                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },

                    child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white),
                      
                  ),
                  ),
                    

                  
            ],
          ),
        ),
      ),
      
    
    );
  }
}