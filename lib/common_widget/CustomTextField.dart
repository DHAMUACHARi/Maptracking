import 'package:flutter/material.dart';


enum DataTypes { email, numeric, alphanumeric }

class CustomTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String hint;
  final String? errorText;
  final TextEditingController? controller;
  final double padding;
  final double topPadding;
  final DataTypes dataType;
  final Key? key;
  final bool isMobileNo;
  final bool isAmount;
  final int maxLength;
  final bool? isReadOnly;



  const CustomTextField(
      {this.key,
        this.onChanged,
        required this.hint,
        this.errorText,
        this.controller,
        this.dataType = DataTypes.alphanumeric,
        this.padding = 3,
        this.topPadding = 3,
        this.isMobileNo = false,
        this.isAmount = false,
        this.maxLength = 35,
        this.isReadOnly = false,
      });

  @override
  CustomTextFieldState createState() =>  CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: _getKeyboardType(),
        readOnly: widget.isReadOnly ?? false,
        decoration: InputDecoration(
          // errorBorder: OutlineInputBorder(
          //   borderSide:BorderSide(width: 1,style: BorderStyle.solid),
          //   borderRadius: BorderRadius.circular(23)
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23)
          ),
           hintStyle: TextStyle(
             fontSize: 16,
             color: Colors.grey
           ),
          hintText: widget.hint,
          border: OutlineInputBorder(

            borderRadius:BorderRadius.circular(23)
          ),
          errorText: widget.errorText,
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.dataType) {
      case DataTypes.email:
        return TextInputType.emailAddress;
      case DataTypes.numeric:
        return TextInputType.number;
      case DataTypes.alphanumeric:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }
}
