// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:crud_sederhana_raden/screens/home_screen.dart';
import 'package:crud_sederhana_raden/services/user_data_manager.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Function to validate login credentials
  Future<bool> validateCredentials() async {
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    final userData = await UserDataManager().getUserData(); // Get user data from UserDataManager

    if (userData != null &&
        userData['username'] == enteredUsername &&
        userData['password'] == enteredPassword) {
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return true;
    } else {
      // Show an error message or alert
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCashBook'),
      ),
      drawer: DrawerNavigation(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'MyCashBook',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call validateCredentials and wait for the result
                final isValid = await validateCredentials();
                if (isValid) {
                  // Navigate to home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
