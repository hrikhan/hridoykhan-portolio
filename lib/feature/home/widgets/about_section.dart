import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_builder.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const List<String> _strengths = [
    'Design responsive Flutter interfaces with reusable components for mobile-first and cross-platform products.',
    'Choose the right state management approach with Riverpod, GetX, or Bloc based on product complexity and team workflow.',
    'Build production-ready features with clean architecture, local caching, secure storage, and performance-aware code.',
    'Integrate REST APIs, Firebase services, notifications, and AI-assisted workflows to solve real product needs.',
    'Contribute as a team lead when needed by guiding delivery, supporting teammates, and helping maintain development quality.',
  ];

  static const List<String> _education = [
    'City University | B.Sc in CSE | Ongoing undergraduate studies focused on software engineering.',
    'Ideal College | Higher Secondary Certificate | 2019 - 2021',
    'Active in tech club workshops, coding competitions, and collaborative team projects.',
    'Continuous learning through advanced Flutter coursework, product case studies, and hands-on client work.',
  ];

  static const List<String> _leadership = [
    'Took team lead responsibility at Softvence alongside hands-on Flutter delivery.',
    'Helped coordinate feature progress, unblock teammates, and keep implementation aligned with product goals.',
    'Balanced delivery quality, team communication, and practical execution across active projects.',
  ];

  static const List<_ProfilePill> _pills = [
    _ProfilePill(label: 'Experience', value: '2+ Years'),
    _ProfilePill(label: 'Products Shipped', value: '10+ Apps'),
    _ProfilePill(label: 'Core Stack', value: 'Flutter + Dart'),
    _ProfilePill(label: 'Focus', value: 'UI, API, AI'),
    _ProfilePill(label: 'Leadership', value: 'Team Lead Experience'),
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
            final isDesktop = sizingInfo.isDesktop;
            final leftContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  constraints: const BoxConstraints(maxWidth: 980),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I am a Flutter developer focused on turning product ideas into reliable, high-quality applications that feel polished and practical in real use. Over the last 2+ years, I have contributed to 10+ production projects across education, commerce, services, productivity, and utility domains.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'My work combines thoughtful UI implementation with clean architecture, API integration, local storage, performance tuning, and release-focused delivery. I am comfortable building complete features from interface to backend integration while keeping code maintainable and scalable for growing products.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'At Softvence, I have also taken team lead responsibilities in addition to development work, helping coordinate tasks, support teammates, and keep project delivery aligned with product goals. This gives me experience not only as an individual contributor, but also as someone who can guide implementation and maintain team momentum.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  constraints: BoxConstraints(maxWidth: 760),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFF1DE), Colors.white],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Text(
                    'I build products, improve workflows, and contribute leadership where needed so teams can move faster with better quality.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _pills
                      .map((pill) => _ProfilePillChip(pill: pill))
                      .toList(),
                ),
              ],
            );

            final rightContent = const Column(
              children: [
                _DetailCard(
                  title: 'Team Lead Experience',
                  subtitle:
                      'Leadership responsibility alongside product delivery at Softvence.',
                  items: _leadership,
                  icon: Icons.groups_rounded,
                  accentColor: AppColors.primary,
                ),
                SizedBox(height: 16),
                _DetailCard(
                  title: 'Core Strengths',
                  subtitle:
                      'The technical areas I use most in day-to-day delivery.',
                  items: _strengths,
                  icon: Icons.bolt_rounded,
                  accentColor: AppColors.primary,
                ),
                SizedBox(height: 16),
                _DetailCard(
                  title: 'Education & Credentials',
                  subtitle:
                      'Academic background, community activity, and continuous learning.',
                  items: _education,
                  icon: Icons.school_rounded,
                  accentColor: AppColors.primaryHover,
                ),
              ],
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 11, child: leftContent),
                  const SizedBox(width: 28),
                  Expanded(flex: 9, child: rightContent),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [leftContent, const SizedBox(height: 28), rightContent],
            );
          },
        ),
      ),
    );
  }
}

class _ProfilePill {
  const _ProfilePill({required this.label, required this.value});

  final String label;
  final String value;
}

class _ProfilePillChip extends StatelessWidget {
  const _ProfilePillChip({required this.pill});

  final _ProfilePill pill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            pill.label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            pill.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.icon,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final List<String> items;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor.withValues(alpha: 0.14), Colors.white],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.14),
            blurRadius: 20,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, size: 18, color: accentColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
