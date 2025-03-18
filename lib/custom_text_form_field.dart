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
  final Color textColor;
  final bool readOnly;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextCapitalization capitalization;
  final String? Function(String?)? validator;

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
        this.readOnly=false,
        this.textColor=Colors.black,
        this.validator,
        this.onTap,
        this.capitalization=TextCapitalization.words,
        this.borderColor=Colors.grey});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText:obscure ,
      maxLines:maxLines ,
      textCapitalization: capitalization,
      onTap: onTap,
      readOnly:readOnly ,
      validator: validator,
      keyboardType: keyBoardType,

      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor,),),

        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),),
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
