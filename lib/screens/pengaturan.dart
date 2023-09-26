// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/models/user.dart';
import 'package:crud_sederhana_raden/services/user_service.dart';
import 'package:crud_sederhana_raden/services/user_data_manager.dart';

class Pengaturan extends StatefulWidget {
  final int userId; // Pass the user ID from HomeScreen

  Pengaturan({required this.userId});

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  late User _user = User(username: '', password: ''); // Initialize with empty values
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    // Fetch user data based on the user's ID
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await _userService.getUserById(widget.userId);
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        // Initialize _user with the fetched data
        _user = User.fromMap(userData.first);
        _usernameController.text = _user.username;
        _passwordController.text = _user.password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSave() async {
    final newUsername = _usernameController.text;
    final newPassword = _passwordController.text;
    
    // Update the user data
    _user.username = newUsername;
    _user.password = newPassword;

    // Update the user data using UserService
    final result = await _userService.updateUser(_user);

    if (result != null && result > 0) {
      // Successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully.'),
        ),
      );
    } else {
      // Failed to update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile.'),
        ),
      );
    }
  }
}
