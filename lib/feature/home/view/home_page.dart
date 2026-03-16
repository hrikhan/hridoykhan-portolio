import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../core/widgets/responsive_builder.dart';
import '../../../core/widgets/scroll_reveal.dart';
import '../controller/home_controller.dart';
import '../controller/scroll_hint_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar.dart';
import '../widgets/projects_section.dart';
import '../widgets/scroll_hint.dart';
import '../widgets/skills_section.dart';
import '../widgets/stats_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ScrollHintController>()) {
      Get.put(ScrollHintController(homeController: controller));
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          const Positioned.fill(child: _HomeBackground()),
          ResponsiveBuilder(
            builder: (context, sizingInfo) {
              return SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: Navbar.height),
                    Padding(
                      padding: Breakpoints.pagePadding(sizingInfo.deviceType),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1400),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionAnchor(
                                anchorKey: controller.homeKey,
                                child: const ScrollReveal(child: HeroSection()),
                              ),
                              const SizedBox(height: 24),
                              SectionAnchor(
                                anchorKey: controller.statsKey,
                                child: const ScrollReveal(
                                  delay: Duration(milliseconds: 40),
                                  child: StatsSection(),
                                ),
                              ),
                              const SizedBox(height: 32),
                              SectionAnchor(
                                anchorKey: controller.projectsKey,
                                child: const ScrollReveal(
                                  delay: Duration(milliseconds: 60),
                                  child: ProjectsSection(),
                                ),
                              ),
                              const SizedBox(height: 32),
                              const ScrollReveal(
                                delay: Duration(milliseconds: 80),
                                child: SkillsSection(),
                              ),
                              const SizedBox(height: 32),
                              const ScrollReveal(
                                delay: Duration(milliseconds: 100),
                                child: ExperienceSection(),
                              ),
                              const SizedBox(height: 32),
                              SectionAnchor(
                                anchorKey: controller.aboutKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    ScrollReveal(
                                      delay: Duration(milliseconds: 120),
                                      child: AboutSection(),
                                    ),
                                    SizedBox(height: 32),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SectionAnchor(
                      anchorKey: controller.contactKey,
                      child: const ScrollReveal(
                        delay: Duration(milliseconds: 140),
                        child: ContactSection(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const ScrollHint(),
          Navbar(controller: controller),
        ],
      ),
    );
  }
}

class SectionAnchor extends StatelessWidget {
  const SectionAnchor({required this.anchorKey, required this.child})
    : super(key: anchorKey);

  final GlobalKey anchorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final width = size.width;
          final height = size.height;

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.backgroundLight,
                      AppColors.backgroundLight.withValues(alpha: 0.96),
                      const Color(0xFFFFFBF5),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -width * 0.12,
                top: height * 0.06,
                child: const _BackgroundShape(
                  width: 260,
                  height: 260,
                  opacity: 0.12,
                  borderRadius: 80,
                  angle: -0.22,
                  colors: [AppColors.primary, Color(0xFFFFB14D)],
                ),
              ),
              Positioned(
                right: -width * 0.08,
                top: height * 0.2,
                child: const _BackgroundShape(
                  width: 320,
                  height: 180,
                  opacity: 0.1,
                  borderRadius: 40,
                  angle: 0.34,
                  colors: [Color(0xFFFFA726), AppColors.primaryHover],
                ),
              ),
              Positioned(
                left: width * 0.12,
                top: height * 0.48,
                child: const _BackgroundShape(
                  width: 160,
                  height: 160,
                  opacity: 0.08,
                  borderRadius: 999,
                  angle: 0,
                  colors: [AppColors.primary, Color(0xFFFFC36B)],
                ),
              ),
              Positioned(
                right: width * 0.1,
                bottom: height * 0.16,
                child: const _BackgroundShape(
                  width: 280,
                  height: 140,
                  opacity: 0.08,
                  borderRadius: 999,
                  angle: -0.28,
                  colors: [AppColors.primaryHover, AppColors.primary],
                ),
              ),
              Positioned(
                left: width * 0.38,
                bottom: -20,
                child: const _BackgroundShape(
                  width: 180,
                  height: 180,
                  opacity: 0.06,
                  borderRadius: 48,
                  angle: 0.52,
                  colors: [Color(0xFFFF9F1C), Color(0xFFFFC46B)],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BackgroundShape extends StatelessWidget {
  const _BackgroundShape({
    required this.width,
    required this.height,
    required this.opacity,
    required this.borderRadius,
    required this.angle,
    required this.colors,
  });

  final double width;
  final double height;
  final double opacity;
  final double borderRadius;
  final double angle;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.16),
                blurRadius: 48,
                offset: const Offset(0, 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
