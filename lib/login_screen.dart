import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/home_screen.dart';
import 'package:to_do_app_flutter/password_reset_screen.dart';
import 'package:to_do_app_flutter/services/auth_services.dart';
import 'package:to_do_app_flutter/signup.dart';
import 'package:to_do_app_flutter/password_reset_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Welcome back",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "LogIn Here",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
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
              SizedBox(height: 20),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _errorMessage = null;
                    });

                    try {
                      User? user = await _auth.signInWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passController.text.trim(),
                      );

                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        if (e.code == 'channel-error') {
                          _errorMessage = 'Enter Email and password';
                        } else if (e.code == 'invalid-credential') {
                          _errorMessage = 'The email or password you entered is incorrect. Please try again.';
                        } 
			                    else if (e.code == 'invalid-email') {
                          _errorMessage = 'Please enter a valid email address.';
			                    } else if (e.code == 'too-many-requests'){
                          _errorMessage = 'Too many login attempts. Please wait a few minutes and try again.';
                        }

                        
                          
                      });
                    } catch (e) {
                      setState(() {
                        _errorMessage =
                            'An error occurred. Please check your credentials and try again.';
                      });
                    }
                  },
                  child: Text(
                    "LogIn",
                    style: TextStyle(color: Colors.indigo, fontSize: 18),
                  ),
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
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordResetScreen(),
                    ),
                  );
                },
                
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
