/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String token;
  final String email;

  const ProfileScreen({Key? key, required this.token, required this.email})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /*String? firstname;
  String? lastname;
  String? email;
  String? role;
  String? password;
  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';
  bool isPasswordVisible = false;*/

  @override
  void initState() {
    super.initState();
    //fetchUserData();
  }/*

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.189.54:4000/api/user/email/${widget.email}'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          firstname = responseData['firstname'] as String? ??
              ''; // Use empty string if Null
          lastname = responseData['lastname'] as String? ?? '';
          email = responseData['email'] as String? ?? '';
          role = responseData['role'] as String? ?? '';
          password = responseData['password'] as String? ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to retrieve user profile data');
      }
    } catch (error) {
      setState(() {
        isError = true;
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 20),
            ),
            // _buildTextField('Prénom', firstname),
            /*_buildTextField('Nom', lastname),
            _buildTextField('Adresse Email', email),
            _buildTextField('Role', role),
            _buildTextField(
              'Mot de passe',
              password,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              obscureText: !isPasswordVisible,
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? value,
      {Widget? suffixIcon, bool obscureText = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
      readOnly: true,
      controller: TextEditingController(text: value ?? ''),
      obscureText: obscureText,
    );
  }
}
*/
import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  final String token;
  final String? email; 

  const ProfileScreen({Key? key, required this.token, this.email})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email: ${widget.email ?? 'N/A'}', // Use 'N/A' if email is null
              style: TextStyle(fontSize: 20),
            ),
            // Other widgets and functionalities can be added here
          ],
        ),
      ),
    );
  }
}
