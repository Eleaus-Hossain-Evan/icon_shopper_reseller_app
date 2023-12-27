import 'package:flutter/material.dart';
import 'package:icon_shopper_reseller_app/core/app_ui/app_ui.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

kShowBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return showMaterialModalBottomSheet(
    // expand: false,
    context: context,
    builder: (context) => child,
  );
}

kShowFloatBottomSheet({
  required BuildContext context,
  required Widget child,
}) async {
  final result = await showCustomModalBottomSheet(
      context: context,
      builder: (context) => child,
      containerWidget: (_, animation, child) => FloatingModal(
            child: child,
          ),
      expand: false);

  return result;
}

kShowBarModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return showBarModalBottomSheet(
    // expand: false,
    context: context,
    barrierColor: Colors.black38,
    builder: (context) => child,
  );
}

/// Modal which is styled for the Flutter News Example app.
Future<T?> showAppModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  RouteSettings? routeSettings,
  BoxConstraints? constraints,
  double? elevation,
  Color? barrierColor,
  Color? backgroundColor,
  bool isDismissible = true,
  bool enableDrag = true,
  AnimationController? transitionAnimationController,
}) {
  return showModalBottomSheet(
    context: context,
    builder: builder,
    routeSettings: routeSettings,
    constraints: constraints,
    isScrollControlled: true,
    barrierColor: barrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    transitionAnimationController: transitionAnimationController,
    elevation: elevation,
    backgroundColor: backgroundColor,
  );
}

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: 20.padding,
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: 12.borderRadius,
          child: child,
        ),
      ),
    );
  }
}
