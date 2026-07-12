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
          ResponsiveBuilder(
            builder: (context, sizingInfo) {
              return SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    SectionAnchor(
                      anchorKey: controller.homeKey,
                      child: const ScrollReveal(child: HeroSection()),
                    ),
                    Padding(
                      padding: Breakpoints.pagePadding(sizingInfo.deviceType),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1400),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
