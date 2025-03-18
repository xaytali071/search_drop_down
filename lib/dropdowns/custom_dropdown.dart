export 'custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:search_drop_down/dropdowns/style.dart';

import 'category_overlay.dart';

part 'dropdown_field.dart';

part 'animated_section.dart';

part 'dropdown_overlay.dart';

part 'overlay_builder.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final String? label;
  final String? searchHintText;
  final String? initialValue;
  final int? initialId;
  final bool? isClear;
  final ValueChanged<int?>? onChanged;
  final ValueChanged? onSelected;
  final String? Function(String?)? validator;
  final List list;
  final String title;
  final ValueChanged onSearching;
  final String noData;
  final Widget loadingWidget;
  final bool isLoading;

  const CustomDropdown({
    super.key,
    this.hintText="Hint",
    this.searchHintText="Search",
    this.onChanged,
    this.initialValue,
    this.label,
    this.validator,
    this.initialId,
    this.onSelected,
    this.isClear, required this.list,
     this.title="Title",
    required this.onSearching,
    this.noData = "No data",
    this.loadingWidget = const CircularProgressIndicator(),
     this.isLoading=false,

  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final layerLink = LayerLink();
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _OverlayBuilder(
        overlay: (size, hideCallback) {
          return _DropdownOverlay(
            controller: controller,
            size: size,
            validator: widget.validator != null,
            layerLink: layerLink,
            hideOverlay: hideCallback,
            hintText: widget.searchHintText ?? "",
            onChanged: widget.onChanged,
            initialId: widget.initialId,
            onItemSelect: widget.onSelected,
            list: widget.list,
            title: widget.title,
            onSearching: (d){
              widget.onSearching;
              setState(() {});
            },
            loadingWidget: widget.loadingWidget,
            noData: widget.noData,
            isLoading: widget.isLoading,
          );
        }, child: (void Function() showCallback) {
      if (widget.isClear ?? false) {
        controller.text = '';
      }
      return CompositedTransformTarget(
        link: layerLink,
        child: _DropDownField(
          controller: controller,
          onTap: showCallback,
          hintText: widget.hintText,
          label: widget.label,
          validator: widget.validator,
        ),
      );
    });
  }}