import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/services/auth_services.dart';
import 'package:to_do_app_flutter/widgets/custom_text_form_field.dart';
import 'package:to_do_app_flutter/widgets/custom_elevated_button.dart';
import 'package:to_do_app_flutter/widgets/custom_text_button.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Reset Password"),
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
                  "Reset Password",
                  style: TextStyle(color: Colors.white, fontSize: 30),
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
                SizedBox(height: 20),
                if (_message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      _message!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Send Reset Link",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.sendPasswordResetEmail(_emailController.text.trim());
                        setState(() {
                          _message = "Password reset email sent. Check your inbox.";
                        });
                      } catch (e) {
                        setState(() {
                          _message = e.toString().replaceAll('Exception: ', '');
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextButton(
                  text: "Back to Login",
                  onPressed: () {
                    Navigator.pop(context);
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
