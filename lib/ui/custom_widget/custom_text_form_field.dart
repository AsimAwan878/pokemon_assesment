

import 'package:flutter/material.dart';
import 'package:pokemon/utils/constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextInputType keyBoardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final double height, padding;
  final Color textFieldColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixImage;
  final Widget? suffixImage;
  final bool isPassField;
  bool isObscure;

  CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.keyBoardType,
    this.controller,
    required this.validator,
    this.onTap,
    this.maxLines = 1,
    this.height = 60.0,
    this.padding = 5.0,
    this.textFieldColor = Colors.white,
    required this.textStyle,
    required this.hintStyle,
    this.readOnly=false,
    this.prefixImage,
    this.suffixImage,
    this.isPassField = false,
    required this.isObscure,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyBoardType,
        maxLines: widget.maxLines,
        cursorColor: defaultColor,
        style: widget.textStyle,
        obscureText: widget.isObscure,

        //Decoration
        decoration: InputDecoration(
          prefixIcon: widget.prefixImage,
          suffixIcon: widget.isPassField ? IconButton(
              icon: Icon(
                widget.isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: defaultDarkColor,
              ),
              onPressed: () {
                setState(() {
                  widget.isObscure = !widget.isObscure;
                });
              }
          ) : widget.suffixImage,
          focusColor: Colors.transparent,
          filled: true,
          fillColor: widget.textFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight(context, 0.009)),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
            gapPadding: 0,
          ),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
        ),
      ),
    );
  }
}