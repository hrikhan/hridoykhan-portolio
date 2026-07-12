import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enghridoy/core/theme/app_theme.dart';
import 'package:enghridoy/core/utils/breakpoints.dart';
import 'package:enghridoy/core/widgets/responsive_builder.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SplashScreenController>()) {
      Get.put(SplashScreenController());
    }
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.find<SplashScreenController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: ResponsiveBuilder(
            builder: (context, sizingInfo) {
              final isMobile = sizingInfo.deviceType == DeviceType.mobile;
              final titleStyle =
                  (textTheme.headlineMedium ?? textTheme.headlineSmall)
                      ?.copyWith(
                        fontSize: isMobile ? 42 : 48,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ) ??
                  const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  );
              final subtitleStyle =
                  (textTheme.bodyLarge ?? textTheme.bodyMedium)?.copyWith(
                    fontSize: isMobile ? 16 : 18,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ) ??
                  const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  );
              return Center(
                child: Padding(
                  padding: Breakpoints.pagePadding(sizingInfo.deviceType),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Obx(() {
                      final progressValue = controller.progress.value;
                      final displayText = progressValue.toStringAsFixed(0);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Hridoy Soft', style: titleStyle),
                          const SizedBox(height: 12),
                          Text(
                            'Portfolio crafted with Flutter',
                            style: subtitleStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '$displayText %',
                            style: subtitleStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              value: progressValue / 100,
                              backgroundColor: AppColors.borderLight
                                  .withValues(alpha: 0.5),
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
