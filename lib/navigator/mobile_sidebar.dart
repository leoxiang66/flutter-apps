import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../animation/slide.dart' show EaseOutSlide;
import '../position/position.dart' show FloatingCenterLeft;

class OpenBaseSidebar extends StatelessWidget {
  final List<OpenSidebarItem> children;
  final Color backgroundColor;

  const OpenBaseSidebar(
      {super.key, required this.children, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: backgroundColor,
      child: Column(
        children: children
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: item,
                ))
            .toList(),
      ),
    );
  }
}

class OpenCenterSidebar extends OpenBaseSidebar {
  const OpenCenterSidebar(
      {super.key, required super.children, required super.backgroundColor})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: super.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: item,
                ))
            .toList(),
      ),
    );
  }
}

class OpenCenterHoverHiddenSidebar extends StatefulWidget {
  const OpenCenterHoverHiddenSidebar({
    Key? key,
    this.floatingIcon = const Icon(
      Icons.chevron_right,
      size: 40,
      color: Colors.blue,
    ),
    required this.children,
    required this.backgroundColor,
  }) : super(
          key: key,
        );

  final List<OpenSidebarItem> children;
  final Color backgroundColor;
  final Widget floatingIcon;

  @override
  _OpenCenterHoverHiddenSidebarState createState() =>
      _OpenCenterHoverHiddenSidebarState();
}

class _OpenCenterHoverHiddenSidebarState
    extends State<OpenCenterHoverHiddenSidebar> {
  bool _isHovered = false;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        color: widget.backgroundColor,
        child: _isHovered
            ? MouseRegion(
                onEnter: _onEnter,
                onExit: _onExit,
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.children
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: item,
                            ))
                        .toList(),
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 40,
                child: Center(
                    child: SizedBox(
                  // width: 40,
                  height: 40,
                  child: MouseRegion(
                    onEnter: _onEnter,
                    onExit: _onExit,
                    child: widget.floatingIcon,
                  ),
                )),
              ));
  }
}

class OpenCenterClickHiddenSidebar extends StatefulWidget {
  const OpenCenterClickHiddenSidebar({
    Key? key,
    this.floatingIcon = const Icon(
      Icons.chevron_right,
      size: 40,
      color: Colors.blue,
    ),
    required this.children,
    required this.backgroundColor,
  }) : super(
          key: key,
        );

  final List<OpenSidebarItem> children;
  final Color backgroundColor;
  final Widget floatingIcon;

  @override
  _OpenCenterClickHiddenSidebarState createState() =>
      _OpenCenterClickHiddenSidebarState();
}

class _OpenCenterClickHiddenSidebarState
    extends State<OpenCenterClickHiddenSidebar> {
  bool _show = false;

  void _showSidebar() {
    setState(() {
      _show = true;
    });
  }

  void _hideSidebar() {
    setState(() {
      _show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = widget.children
        .map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: item,
            ))
        .toList();
    list.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: GestureDetector(
          onTap: () => _hideSidebar(),
          child: Icon(
            Icons.chevron_left_rounded,
            size: 40,
          )),
    ));
    return Container(
        // duration: Duration(milliseconds: 200),
        color: widget.backgroundColor,
        child: _show
            ? EaseOutSlide(
              start: Offset(-2, 0),
              end: Offset(0,0),
              duration: Duration(milliseconds: 200),
              child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: list,
                  ),
                ),
            )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 40,
                child: Center(
                    child: SizedBox(
                  // width: 40,
                  height: 40,
                  child: GestureDetector(
                      onTap: () => _showSidebar(), child: widget.floatingIcon),
                )),
              ));
  }
}

class OpenSidebarItem extends StatefulWidget {
  final Widget icon;
  final String tooltip;

  const OpenSidebarItem({super.key, required this.icon, required this.tooltip});

  @override
  _OpenSidebarItemState createState() => _OpenSidebarItemState();
}

class _OpenSidebarItemState extends State<OpenSidebarItem> {
  bool _isHovered = false;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: _isHovered
          ? Tooltip(
              message: widget.tooltip,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              textStyle: const TextStyle(color: Colors.black, fontSize: 13),
              verticalOffset: 20,
              preferBelow: true,
              child: widget.icon,
            )
          : widget.icon,
    );
  }
}
