import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';


const kMobilePhysics = BouncingScrollPhysics();
const kDesktopPhysics = NeverScrollableScrollPhysics();

class ScrollState with ChangeNotifier {
  final ScrollController controller = ScrollController();
  ScrollPhysics physics = kDesktopPhysics;
  double futurePosition = 0;

  final ScrollPhysics mobilePhysics;
  final int durationMS;

  ScrollState(this.mobilePhysics, this.durationMS);

  void handleDesktopScroll(PointerSignalEvent event) {
    // Ensure desktop physics is being used.
    if (physics == kMobilePhysics) {
      physics = kDesktopPhysics;
      notifyListeners();
      return;
    }
    if (event is PointerScrollEvent) {
      // Return if limit is reached in either direction.
      if (controller.position.atEdge) {
        final dy = event.scrollDelta.dy;
        // Return if bounds exceeded.
        if (controller.position.pixels == 0) {
          if (dy < 0) return;
        } else {
          if (dy > 0) return;
        }
      }
      futurePosition += event.scrollDelta.dy;

      controller.animateTo(
        futurePosition,
        duration: Duration(milliseconds: durationMS),
        curve: Curves.linear,
      );
    }
  }

  void handleTouchScroll(PointerDownEvent event) {
    if (physics == kDesktopPhysics) {
      physics = mobilePhysics;
      notifyListeners();
    }
  }
}

class DynMouseScroll extends StatelessWidget {
  final ScrollPhysics mobilePhysics;
  final int durationMS;
  final Function(BuildContext, ScrollController, ScrollPhysics) builder;

  const DynMouseScroll({
    super.key,
    this.mobilePhysics = kMobilePhysics,
    this.durationMS = 200,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScrollState>(
        create: (context) => ScrollState(mobilePhysics, durationMS),
        builder: (context, _) {
          final scrollState = context.read<ScrollState>();
          final controller = scrollState.controller;
          final physics = context.select((ScrollState s) => s.physics);
          return Listener(
            onPointerSignal: scrollState.handleDesktopScroll,
            onPointerDown: scrollState.handleTouchScroll,
            child: builder(context, controller, physics),
          );
        });
  }
}
