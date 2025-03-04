import 'package:flutter/material.dart';
import 'package:ug/components/ProfileScreen/create_profile.dart';
import 'package:ug/components/ProfileScreen/profile_name.dart';
import 'package:ug/components/ProfileScreen/profile_photo.dart';
import 'package:ug/screens/Home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 145),
            ProfilePhoto(),
            SizedBox(height: 20),
            ProfileName(
              hintText: "Enter Your Name",
              labelText: "Name",
              prefixIcon: Icons.person,
              textColor: Colors.black,
            ),
            CreateProfile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              buttonText: "Create Profile",
            ),
          ],
        ),
      ),
    );
  }
}
