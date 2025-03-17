part of 'custom_dropdown.dart';

class _DropDownField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? hintText;
  final String? label;
  final Color borderColor;
  final String? Function(String?)? validator;

  const _DropDownField({
    required this.controller,
    required this.onTap,
    this.hintText,
    this.label,
    this.validator,
    this.borderColor=Colors.grey,
  });

  @override
  State<_DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<_DropDownField> {
  String? prevText;
  bool listenChanges = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listenItemChanges);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listenItemChanges);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.addListener(listenItemChanges);
  }

  void listenItemChanges() {
    if (listenChanges) {
      prevText = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(right: 6, bottom: 4),
              child: Text(
                "fgrh",
              ),
            ),
          TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: widget.onTap,
            validator: widget.validator,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: widget.controller.text.isNotEmpty &&
                        widget.validator == null
                    ? () {
                        widget.controller.clear();
                        setState(() {});
                      }
                    : null,
                icon: Icon(
                  widget.controller.text.isNotEmpty && widget.validator == null
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,

                  size: 18,
                ),
              ),
              enabledBorder: _border(widget.borderColor),
              errorBorder: _border(widget.borderColor),
              border: _border(widget.borderColor),
              focusedErrorBorder: _border(widget.borderColor),
              disabledBorder: _border(widget.borderColor),
              focusedBorder: _border(widget.borderColor),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              hintText: widget.hintText ?? '',
              hoverColor: CustomStyle.transparent,

            ),
          ),
        ],
      );
  }

  _border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide.merge(
          BorderSide(color: color,width: 0.5),
          BorderSide(color: color,width: 0.5),
        ),
        borderRadius: BorderRadius.circular(12));
  }
}
