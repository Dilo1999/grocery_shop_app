import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'LogingScreen.dart'; // Import the login screen

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


//State Management & Image Picker
class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  Future<void> _pickImage() async {

    //Image Picker
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }




  //UI part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [


          //Header Section (Custom Profile Header)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),


            child: Row(
              children: [

                //Profile Picture & Info
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 40, color: Colors.grey)
                        : null,
                  ),
                ),



                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dilshan Senanayaka',
                      style: TextStyle(
                          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'View & edit profile',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                )



              ],
            ),
          ),





          const SizedBox(height: 30),
          _buildOptionTile(Icons.settings, 'Account Settings'),
          _buildOptionTile(Icons.notifications, 'Notifications'),
          _buildOptionTile(Icons.security, 'Privacy & Security'),
          _buildOptionTile(Icons.help_outline, 'Help Center'),


          _buildOptionTile(Icons.logout, 'Logout', color: Colors.redAccent, onTap: () {
            // Perform logout logic here (if any), then navigate
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LogingScreen()),
              (route) => false,
            );
          }),




        ],
      ),
    );
  }



  Widget _buildOptionTile(IconData icon, String title,
      {Color? color, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(icon, color: color ?? Colors.deepOrange),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: color ?? Colors.black87,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap ?? () {},
        ),
      ),
    );
  }
}
