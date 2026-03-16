import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/hover.dart';

class TechChipData {
  const TechChipData({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
}

class TechStackChips extends StatelessWidget {
  const TechStackChips({super.key});

  static const List<TechChipData> _chips = [
    TechChipData(
      icon: Icons.flutter_dash,
      iconColor: AppColors.primary,
      label: 'Flutter',
    ),
    TechChipData(icon: Icons.code, iconColor: Color(0xFF0175C2), label: 'Dart'),
    TechChipData(
      icon: Icons.hub_outlined,
      iconColor: Color(0xFF0F766E),
      label: 'REST API',
    ),
    TechChipData(
      icon: Icons.account_tree_outlined,
      iconColor: Color(0xFF2563EB),
      label: 'Riverpod',
    ),
    TechChipData(
      icon: Icons.cloud_circle,
      iconColor: Color(0xFFFFCA28),
      label: 'Firebase',
    ),
    TechChipData(
      icon: Icons.auto_awesome,
      iconColor: Color(0xFFEA580C),
      label: 'AI Features',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _chips.map((chip) => _TechChip(data: chip)).toList(),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.data});

  final TechChipData data;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.chipLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.icon, size: 18, color: data.iconColor),
              const SizedBox(width: 8),
              Text(
                data.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
