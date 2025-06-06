import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/routes/route_manager.dart';
import '../../../config/themes/text_style.dart';

enum ToastType { success, error, warning }

OverlayEntry? _currentToast;

void showToast(
  BuildContext context, {
  String message = "This is a toast message",
  ToastType type = ToastType.success,
}) {
  final overlayState = Overlay.of(context, rootOverlay: true);

  _currentToast?.remove();
  _currentToast = null;

  final overlayEntry = OverlayEntry(
    builder: (context) => _ToastWidget(
      message: message,
      type: type,
    ),
  );

  _currentToast = overlayEntry;
  overlayState.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    _currentToast?.remove();
    _currentToast = null;
  });
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;

  const _ToastWidget({
    required this.message,
    required this.type,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Color _bgColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.type == ToastType.error || widget.type == ToastType.warning
          ? const Offset(0, -2.5)
          : const Offset(1.5, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    switch (widget.type) {
      case ToastType.success:
        _bgColor = RouteManager.ctx?.primaryColor ?? Colors.green;
        break;
      case ToastType.error:
        _bgColor = Colors.red;
        break;
      case ToastType.warning:
        _bgColor = Colors.yellow;
        break;
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).padding.top + 100).h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSurface,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.type == ToastType.success
                      ? Icons.check_circle
                      : widget.type == ToastType.error
                          ? Icons.error
                          : Icons.warning,
                  color: widget.type == ToastType.success
                      ? Colors.green
                      : widget.type == ToastType.error
                          ? Colors.red
                          : Colors.yellow,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    widget.message,
                    style: getMediumStyle(
                      color: widget.type == ToastType.success
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
