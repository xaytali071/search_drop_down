part of 'custom_dropdown.dart';

class _DropdownOverlay extends StatefulWidget {
  final int? initialId;
  final bool validator;
  final TextEditingController controller;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText;
  final ValueChanged<int?>? onChanged;
  final ValueChanged? onItemSelect;
  final List list;
  final String title;
  final ValueChanged onSearching;
  final bool isLoading;
  final String noData;
  final Widget loadingWidget;

  const _DropdownOverlay({
    required this.controller,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.hintText,
    required this.onChanged,
    required this.initialId,
    required this.onItemSelect,
    required this.validator,
    required this.list,
    this.title = "Title",
    required this.onSearching,
    this.isLoading = false,
    this.noData = "No data",
    this.loadingWidget = const CircularProgressIndicator(),
  });

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay> {
  bool displayOverly = true;
  bool displayOverlayBottom = true;
  final key1 = GlobalKey(), key2 = GlobalKey();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final render1 = key1.currentContext?.findRenderObject() as RenderBox;
      final render2 = key2.currentContext?.findRenderObject() as RenderBox;
      final screenHeight = MediaQuery.sizeOf(context).height;
      double y = render1.localToGlobal(Offset.zero).dy;
      if (screenHeight - y < render2.size.height) {
        displayOverlayBottom = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayOffset = Offset(-12, displayOverlayBottom ? 0 : 60);

    final child = Stack(
      children: [
        Positioned(
          width: 244,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            followerAnchor:
                displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
            showWhenUnlinked: false,
            offset: overlayOffset,
            child: Container(
              key: key1,
              padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(blurRadius: 24.0, offset: const Offset(0, 6)),
                  ],
                ),
                child: Material(
                  color: CustomStyle.white,
                  child: AnimatedSection(
                    animationDismissed: widget.hideOverlay,
                    expand: displayOverly,
                    axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                    child: SizedBox(
                      key: key2,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NotificationListener<
                          OverscrollIndicatorNotification
                        >(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (!widget.validator)
                                      GestureDetector(
                                        onTap: () {
                                          widget.controller.clear();
                                          widget.onItemSelect?.call(null);
                                          setState(() => displayOverly = false);
                                        },
                                        child: Text("Clear"),
                                      ),
                                    SizedBox(height: 12),
                                    Icon(
                                      displayOverlayBottom
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),

                             CustomTextFormField(hint: "sdf",onChanged: widget.onSearching),
                              widget.isLoading
                                  ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30),
                                        widget.loadingWidget,
                                      ],
                                    ),
                                  )
                                  : widget.list.isEmpty
                                  ? Center(child: Text(widget.noData))
                                  : Expanded(
                                    child: ListView.builder(
                                      itemCount: widget.list.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Material(
                                                color: CustomStyle.transparent,
                                                child: InkWell(
                                                  splashColor:
                                                      CustomStyle.transparent,
                                                  onTap: () {
                                                    widget.controller.text =
                                                        widget.list[index];
                                                    widget.onChanged?.call(
                                                      widget.list[index],
                                                    );
                                                    widget.onItemSelect != null
                                                        ? (widget.list[index])
                                                        : null;
                                                    setState(
                                                      () =>
                                                          displayOverly = false,
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 8,
                                                        ),
                                                    width: double.infinity,
                                                    child: Text(
                                                      widget.list[index],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                                thickness: 1,
                                                color: CustomStyle.border,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: Container(color: Colors.transparent, child: child),
    );
  }

  onChanged(value) {
    widget.controller.text = value.title.toString();
    widget.onChanged?.call(value.id);
    setState(() => displayOverly = false);
  }
}
