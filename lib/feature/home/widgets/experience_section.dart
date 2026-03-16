import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_builder.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<_ExperienceItem> _experiences = [
    _ExperienceItem(
      company: 'Softvence',
      role: 'Flutter Developer',
      duration: 'July 2025 - Present',
      accent: AppColors.primary,
      points: [
        'Build and maintain cross-platform applications for service, education, commerce, and utility products using Flutter and Dart.',
        'Contribute team lead support at Softvence by helping guide implementation, coordinate delivery, and support other developers when project needs require it.',
        'Translate product requirements into reusable UI systems, responsive screens, and production-ready user flows.',
        'Integrate REST APIs, AI-assisted services, notifications, and local persistence for real business workflows.',
        'Support end-to-end delivery through debugging, performance improvement, release preparation, and deployment coordination.',
      ],
    ),
    _ExperienceItem(
      company: 'SpondonIT',
      role: 'Flutter Developer Intern',
      duration: '3 Months',
      accent: AppColors.primaryHover,
      points: [
        'Contributed to InfixLMS and Infix Edu by refreshing interfaces and improving navigation for students and educators.',
        'Implemented multilingual support and localization improvements to make the products more accessible.',
        'Worked with the team to fix usability issues, improve responsiveness, and strengthen overall user experience quality.',
      ],
    ),
  ];

  static const List<String> _deliveryHighlights = [
    'Shipped real Flutter products across multiple domains including billing, education, service, and productivity.',
    'Comfortable with reusable architecture, state management decisions, and production-focused code organization.',
    'Hands-on delivery experience with APIs, AI-assisted features, notifications, local storage, and release support.',
    'Able to collaborate with designers, backend teams, and stakeholders to move features from concept to deployment.',
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
            final summaryCard = Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Professional Experience',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hands-on product experience covering Flutter development, API integration, UI refinement, and release-ready delivery.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 18),
                  _SummaryMetricRow(),
                ],
              ),
            );

            final timeline = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Work Experience',
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
                    'A focused view of the roles where I built, improved, and shipped Flutter applications for real users, client teams, and business workflows.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ..._experiences.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ExperienceCard(item: item),
                  ),
                ),
                const SizedBox(height: 8),
                const _HighlightsCard(items: _deliveryHighlights),
              ],
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: timeline),
                  const SizedBox(width: 24),
                  Expanded(child: summaryCard),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [timeline, const SizedBox(height: 16), summaryCard],
            );
          },
        ),
      ),
    );
  }
}

class _ExperienceItem {
  const _ExperienceItem({
    required this.company,
    required this.role,
    required this.duration,
    required this.points,
    required this.accent,
  });

  final String company;
  final String role;
  final String duration;
  final List<String> points;
  final Color accent;
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.item});

  final _ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.accent.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.work_outline, color: item.accent, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.company,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.role,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: item.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.chipLight,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Text(
              item.duration,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 18),
          ...item.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_right_alt, color: item.accent, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      point,
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
          ),
        ],
      ),
    );
  }
}

class _HighlightsCard extends StatelessWidget {
  const _HighlightsCard({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Highlights',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.bolt, size: 18, color: AppColors.primary),
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
          ),
        ],
      ),
    );
  }
}

class _SummaryMetricRow extends StatelessWidget {
  const _SummaryMetricRow();

  @override
  Widget build(BuildContext context) {
    const metrics = [
      _SummaryMetric(label: 'Experience', value: '2+'),
      _SummaryMetric(label: 'Projects', value: '10+'),
      _SummaryMetric(label: 'Releases', value: '2'),
    ];

    return Row(
      children: metrics
          .map(
            (metric) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        metric.value,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SummaryMetric {
  const _SummaryMetric({required this.label, required this.value});

  final String label;
  final String value;
}
