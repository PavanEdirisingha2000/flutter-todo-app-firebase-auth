import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/home_screen.dart';
import 'package:to_do_app_flutter/login_screen.dart';
import 'package:to_do_app_flutter/services/auth_services.dart';
import 'package:to_do_app_flutter/widgets/custom_text_form_field.dart';
import 'package:to_do_app_flutter/widgets/custom_elevated_button.dart';
import 'package:to_do_app_flutter/widgets/custom_text_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  "Register Here",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: _emailController,
                  label: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                CustomTextFormField(
                  controller: _passController,
                  label: "Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Register",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        User? user = await _auth.registerWithEmailAndPassword(
                          _emailController.text,
                          _passController.text,
                        );
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          _errorMessage =
                              e.toString().replaceAll('Exception: ', '');
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextButton(
                  text: "Already have an account? Login Here",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
