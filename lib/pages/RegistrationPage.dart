import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created for ${_nameController.text}!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Name"),
                  validator: (value) => value!.isEmpty ? "Name is required" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Email is required";
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    return emailRegex.hasMatch(value) ? null : "Enter a valid email";
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(hintText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? "Phone number is required" : null,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Create Account"),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back to Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}