//part of 'overlay_items.dart';

import 'package:flutter/material.dart';
import 'package:search_drop_down/dropdowns/style.dart';

import 'dropdown_item_data.dart';


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
          onChanged: (value) {
            widget.onChanged!(value);
            debugPrint('===> search field value: $value');
          },
          cursorWidth: 1,

          decoration: InputDecoration(
            filled: true,
            fillColor: widget.filledColor,
            constraints: BoxConstraints.tightFor(height: 30),
            hoverColor: Colors.transparent,
            hintText: widget.searchHintText,
            contentPadding: EdgeInsets.zero,

            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
              ),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
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

class _ItemsList extends StatelessWidget {
  final ScrollController scrollController;
  final List<DropDownItemData> items;
  final ValueSetter<DropDownItemData> onItemSelect;

  const _ItemsList({
    required this.scrollController,
    required this.items,
    required this.onItemSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => onItemSelect(items[index]),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      child: Text(
                        items[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: CustomStyle.border,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}