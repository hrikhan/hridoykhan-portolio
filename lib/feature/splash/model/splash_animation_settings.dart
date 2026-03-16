import 'package:flutter/material.dart';

import 'package:enghridoy/core/theme/app_theme.dart';

class SplashAnimationSettings {
  const SplashAnimationSettings({
    this.loadingDuration = const Duration(milliseconds: 850),
    this.gradientPalettes = const [
      [AppColors.backgroundLight, Color(0xFFF2F3F5)],
    ],
    this.logoPulseRange = 0.04,
  });

  final Duration loadingDuration;
  final List<List<Color>> gradientPalettes;
  final double logoPulseRange;
}
