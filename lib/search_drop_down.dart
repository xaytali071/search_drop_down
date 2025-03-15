import 'package:flutter/material.dart';
import 'package:search_drop_down/custom_text_form_field.dart';

class SearchDropDown extends StatefulWidget {
  const SearchDropDown({super.key});

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  @override
  Widget build(BuildContext context) {
    return  CustomTextFormField(hint: "Select", onTap: () {
      showMenu(context: context, items: [
        PopupMenuItem(child: Text("data")),
        PopupMenuItem(child: Text("data1")),
        PopupMenuItem(child: Text("data2")),
        PopupMenuItem(child: Text("data3")),
      ]);
    },);
  }
}
