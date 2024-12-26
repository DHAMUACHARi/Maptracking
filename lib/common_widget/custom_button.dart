
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color color1, color2;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.buttonText,
    required this.color1, required this.color2,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(colors: [color1, color2])),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(

              elevation: 0,
              side: const BorderSide(color: Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              backgroundColor: Colors.transparent),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white,fontSize: 19),
          )),
    );
  }
}
