import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_time_maps/common_widget/custom_button.dart';
import 'package:real_time_maps/resources/color_resources.dart';
import '../../resources/image_resources.dart';

class SignOutScreen extends StatelessWidget {
  final String email;

  const SignOutScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: const Text("Sign Out"),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, buttonColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profile),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  // Email display
                  Text(
                    'Email: $email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: buttonColor1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Password: ••••••••',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  // Sign-out button
                  CustomButton(
                    buttonText: 'Sign Out',
                    color1: buttonColor1,
                    color2: buttonColor2,
                    onPressed: () {
                      _showSignOutConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Are you sure you want to sign out?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "You will need to log in again.",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                buttonText: 'No',
                color1: Colors.white,
                color2: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                buttonText: 'Yes',
                color1: buttonColor1,
                color2: buttonColor2,
                onPressed: () {
                  Navigator.of(context).pop();
                  _signOut(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _signOut(BuildContext context) {
   context.go('/');
  }
}
