import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './RegistorScreen.dart'; // Import register screen
import './ProductScreen.dart';  // Import product screen (for navigation after successful login)


//Stateful Widget Setup
class LogingScreen extends StatefulWidget {
  @override
  _LogingScreenState createState() => _LogingScreenState();
}



class _LogingScreenState extends State<LogingScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;




  //   Login Logic
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

   // Client-Side Validation
    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Email and password are required.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {

      // HTTP POST Request
      final response = await http.post(
        Uri.parse('http://192.168.8.180:3000/login'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );




      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {

        // Login successful, navigate to ProductScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen()),
        );


      } else {
        setState(() => _errorMessage = responseData['error'] ?? 'Login failed.');
      }
    } catch (e) {
      setState(() => _errorMessage = "Error connecting to server.");
    } finally {
      setState(() => _isLoading = false);
    }
  }





// UI Part
 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(



            children: [
              SizedBox(height: 80),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4F40),
                ),
              ),
              SizedBox(height: 40),



              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (_errorMessage != null) SizedBox(height: 20),




              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),




              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 50),



              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFFFF4F40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Login', style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              ),




              SizedBox(height: 100),
              TextButton(
                onPressed: () {
                  // Navigate to Forgot Password
                },
                child: Text('Forgot Password?'),
              ),



              SizedBox(height: 10),


              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistorScreen()),
                  );
                },
                child: Text(
                  "Not registered? Register here",
                  style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],




          ),
        ),
      ),
    ),
  );
}
}
