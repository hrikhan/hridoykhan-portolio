import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/splash_animation_settings.dart';
import '../../home/view/home_page.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SplashScreenController() {
    _settings = const SplashAnimationSettings();
  }

  late final SplashAnimationSettings _settings;
  late AnimationController _animationController;
  final RxDouble progress = 0.0.obs;
  bool _navigated = false;

  Duration get duration => _settings.loadingDuration;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
    _animationController.addListener(_tick);
    _animationController.forward().whenComplete(_routeToHome);
  }

  void _tick() {
    progress.value = _animationController.value * 100;
  }

  void _routeToHome() {
    if (_navigated) return;
    _navigated = true;
    Get.offAll(
      () => HomePage(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void onClose() {
    _animationController
      ..removeListener(_tick)
      ..dispose();
    super.onClose();
  }
}
