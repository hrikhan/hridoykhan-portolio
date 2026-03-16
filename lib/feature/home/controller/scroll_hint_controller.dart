import 'package:get/get.dart';

import 'home_controller.dart';

class ScrollHintController extends GetxController {
  ScrollHintController({required this.homeController});

  final HomeController homeController;

  final RxBool isVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    homeController.scrollController.addListener(_handleScroll);
    _handleScroll();
  }

  void _handleScroll() {
    final hasClients = homeController.scrollController.hasClients;
    final offset = hasClients ? homeController.scrollController.offset : 0.0;
    final nextValue = offset < 56;
    if (isVisible.value != nextValue) {
      isVisible.value = nextValue;
    }
  }

  void scrollToNextSection() {
    homeController.scrollToSection(homeController.statsKey, offset: 72);
  }

  @override
  void onClose() {
    homeController.scrollController.removeListener(_handleScroll);
    super.onClose();
  }
}
