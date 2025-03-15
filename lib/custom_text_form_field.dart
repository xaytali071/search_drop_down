import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? sufix;
  final Widget? perfix;
  final Color borderColor;
  final bool obscure;
  final int maxLines;
  final Color filledColor;
  final double height;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;
  final VoidCallback onTap;

  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.controller,
      this.sufix,
        this.maxLines=1,
      this.perfix,
      this.onChanged,
        this.height=35,
        this.filledColor=Colors.transparent,
      this.keyBoardType = TextInputType.text,
        this.obscure=false,
        this.borderColor=Colors.transparent,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText:obscure ,
      maxLines:maxLines ,
      readOnly: true,
      onTap: onTap,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        fillColor: filledColor.withOpacity(0.5),
        filled: true,
        constraints: BoxConstraints.tightFor(height: height),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        suffixIcon: sufix,
        prefixIcon: perfix,
      ),
    );
  }
}
