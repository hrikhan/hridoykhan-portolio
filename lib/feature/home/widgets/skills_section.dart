import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_builder.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const List<SkillGroup> _groups = [
    SkillGroup(
      title: 'Programming Languages',
      skills: ['Dart', 'JavaScript', 'Java', 'C'],
    ),
    SkillGroup(
      title: 'Framework & UI',
      skills: ['Flutter', 'Responsive Layouts', 'Custom Widgets', 'Animations'],
    ),
    SkillGroup(title: 'State Management', skills: ['GetX', 'Riverpod', 'Bloc']),
    SkillGroup(
      title: 'Architecture',
      skills: [
        'Clean Architecture',
        'Feature-first Structure',
        'Reusable Components',
        'Dependency-aware Design',
      ],
    ),
    SkillGroup(
      title: 'API & Networking',
      skills: ['REST API', 'JSON', 'WebSocket', 'Authentication', 'AI API'],
    ),
    SkillGroup(
      title: 'Storage & Data',
      skills: [
        'SharedPreferences',
        'Hive',
        'Sqflite',
        'GetStorage',
        'Secure Storage',
        'PostgreSQL',
        'MySQL',
      ],
    ),
    SkillGroup(title: 'Version Control', skills: ['Git', 'GitHub', 'GitLab']),
    SkillGroup(
      title: 'Tools & Services',
      skills: [
        'Firebase',
        'Google Cloud',
        'Push Notifications',
        'FCM',
        'Postman',
      ],
    ),
    SkillGroup(
      title: 'Release & Delivery',
      skills: [
        'Google Play Console',
        'Apple App Store',
        'Debugging',
        'QA Support',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: Semantics(
        header: true,
        child: ResponsiveBuilder(
          builder: (context, sizingInfo) {
            return LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 16.0;
                final maxWidth = constraints.maxWidth;
                final columns = maxWidth >= 1080
                    ? 3
                    : maxWidth >= 680
                    ? 2
                    : 1;
                final cardWidth = columns == 1
                    ? maxWidth
                    : (maxWidth - (spacing * (columns - 1))) / columns;
                final cardHeight = columns == 1 ? 210.0 : 190.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Technical Skills',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 920),
                      child: const Text(
                        'A practical overview of the technologies, architecture patterns, and delivery workflow I use to build maintainable Flutter products from interface to release.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.7,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: _groups
                          .map(
                            (group) => SizedBox(
                              width: cardWidth,
                              height: cardHeight,
                              child: _SkillGroupCard(group: group),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SkillGroup {
  const SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  static const String _cardBackgroundImage = 'web/icons/Icon-maskable-512.png';

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                _cardBackgroundImage,
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.lighten,
              ),
            ),
            Positioned(
              right: -20,
              top: -12,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  _cardBackgroundImage,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.94),
                    AppColors.chipLight.withOpacity(0.82),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: group.skills
                        .map((skill) => _SkillChip(label: skill))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.chipLight,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
