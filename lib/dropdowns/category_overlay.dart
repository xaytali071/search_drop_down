//part of 'overlay_items.dart';

import 'package:flutter/material.dart';
import 'package:search_drop_down/dropdowns/style.dart';


class SearchField extends StatefulWidget {
  final String searchHintText;
  final Color filledColor;
  final Color borderColor;
  final Function(String?)? onChanged;

  const SearchField({super.key,
    required this.searchHintText,
    required this.onChanged,
     this.filledColor=Colors.transparent,
     this.borderColor=Colors.grey,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void onClear() {
    if (searchCtrl.text.isNotEmpty) {
      searchCtrl.clear();
      widget.onChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 48,
        child: TextField(
          controller: searchCtrl,
          onChanged: widget.onChanged,
          cursorWidth: 1,
          cursorColor: CustomStyle.textHint,

          decoration: InputDecoration(
            filled: true,
            fillColor: widget.filledColor,
            constraints: BoxConstraints.tightFor(height: 30),
            hoverColor: CustomStyle.transparent,
            hintText: widget.searchHintText,
            contentPadding: EdgeInsets.zero,

            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                size: 20,
              ),
              splashColor: CustomStyle.transparent,
              hoverColor: CustomStyle.transparent,
              onPressed: onClear,
            ),
            enabledBorder: _border(widget.borderColor),
            errorBorder: _border(widget.borderColor),
            border: _border(widget.borderColor),
            focusedErrorBorder: _border(widget.borderColor),
            disabledBorder: _border(widget.borderColor),
            focusedBorder: _border(widget.borderColor),
          ),
        ),
      ),
    );
  }


  _border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide.merge(
          BorderSide(color: color,width: 0.5),
          BorderSide(color: color,width: 0.5),
        ),
        borderRadius: BorderRadius.circular(10));
  }
}

