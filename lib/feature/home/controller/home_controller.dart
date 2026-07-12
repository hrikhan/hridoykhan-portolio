import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/widgets/smooth_scroll_controller.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = SmoothScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey statsKey = GlobalKey();

  void scrollToSection(GlobalKey key, {double offset = 0}) {
    if (!scrollController.hasClients) {
      return;
    }

    final context = key.currentContext;
    if (context == null) {
      return;
    }

    final box = context.findRenderObject();
    if (box is! RenderBox) {
      return;
    }

    final position = box.localToGlobal(Offset.zero);
    final targetOffset = scrollController.offset + position.dy - offset;

    scrollController.animateTo(
      targetOffset.clamp(0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
