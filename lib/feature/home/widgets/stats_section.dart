import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_builder.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  static const List<_StatItemData> _stats = [
    _StatItemData(
      icon: Icons.schedule,
      value: 2,
      suffix: '+',
      label: 'Years Experience',
    ),
    _StatItemData(
      icon: Icons.rocket_launch,
      value: 10,
      suffix: '+',
      label: 'Apps Delivered',
    ),
    _StatItemData(
      icon: Icons.account_tree_outlined,
      value: 3,
      suffix: '',
      label: 'State Patterns',
    ),
    _StatItemData(
      icon: Icons.storefront_outlined,
      value: 2,
      suffix: '',
      label: 'Store Platforms',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          final double videoHeight = sizingInfo.isDesktop
              ? 350
              : sizingInfo.isTablet
              ? 350
              : 300;
          final statsGrid = _StatsGrid(
            stats: _stats,
            alignment: sizingInfo.isDesktop
                ? WrapAlignment.spaceBetween
                : WrapAlignment.start,
          );

          if (sizingInfo.isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _StatsVideoCard(height: videoHeight)),
                const SizedBox(width: 48),
                Expanded(child: statsGrid),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statsGrid,
              const SizedBox(height: 30),
              _StatsVideoCard(height: videoHeight),
            ],
          );
        },
      ),
    );
  }
}

class _StatItemData {
  const _StatItemData({
    required this.icon,
    required this.value,
    required this.suffix,
    required this.label,
  });

  final IconData icon;
  final int value;
  final String suffix;
  final String label;
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats, required this.alignment});

  final List<_StatItemData> stats;
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 48,
      runSpacing: 24,
      alignment: alignment,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: stats.map((item) => _StatItem(data: item)).toList(),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.data});

  final _StatItemData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: data.label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnimatedStatValue(value: data.value, suffix: data.suffix),
              Text(
                data.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedStatValue extends StatelessWidget {
  const _AnimatedStatValue({required this.value, required this.suffix});

  final int value;
  final String suffix;

  String _formatCount(double rawValue) {
    final int rounded = rawValue.round();
    if (rounded >= 1000) {
      final double inThousands = rounded / 1000;
      final bool isWhole = inThousands == inThousands.roundToDouble();
      final String text = isWhole
          ? inThousands.toStringAsFixed(0)
          : inThousands.toStringAsFixed(1);
      return '${text}k';
    }
    return rounded.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Text(
          '${_formatCount(animatedValue)}$suffix',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        );
      },
    );
  }
}

class _StatsVideoCard extends StatefulWidget {
  const _StatsVideoCard({required this.height});

  final double height;

  @override
  State<_StatsVideoCard> createState() => _StatsVideoCardState();
}

class _StatsVideoCardState extends State<_StatsVideoCard> {
  static const String _videoUrl =
      'https://res.cloudinary.com/dofsibxao/video/upload/v1767176267/E-commerce_bU_and_asales_ef1gpz.mp4';

  VideoPlayerController? _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl))
        ..setLooping(true)
        ..setVolume(0);
      _controller = controller;
      controller
          .initialize()
          .then((_) {
            if (!mounted) {
              return;
            }
            setState(() {
              _isReady = true;
            });
            controller.play();
          })
          .catchError((_) {});
    } catch (_) {
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final Widget content = _isReady && controller != null
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          )
        : const _VideoPlaceholder();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: widget.height,
          width: double.infinity,
          child: content,
        ),
      ),
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }
}
