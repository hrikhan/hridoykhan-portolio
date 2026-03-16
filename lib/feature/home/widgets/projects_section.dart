import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/hover.dart';
import '../../../core/widgets/responsive_builder.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<ProjectItem> _projects = [
    ProjectItem(
      title: 'Billedsmart',
      subtitle: 'AI-assisted bill negotiation app',
      techStack: ['Flutter', 'REST API', 'Authentication', 'AI Workflow'],
      tag: 'Billing',
      imageUrl:
          'https://res.cloudinary.com/dn2lldb4m/image/upload/v1773484189/appstore_z7dbc4.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.billsmart.app&pcampaignid=web_share',
      accent: AppColors.primary,
    ),
    ProjectItem(
      title: 'Deep Quran',
      subtitle: 'Quran learning and practice app',
      techStack: ['Flutter', 'REST API', 'Content Delivery', 'Localization'],
      tag: 'Quran',
      imageUrl:
          'https://res.cloudinary.com/dn2lldb4m/image/upload/v1773484410/app_icon_t354ui.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.deepquran.app&pcampaignid=web_share',
      accent: AppColors.primaryHover,
    ),
    ProjectItem(
      title: 'Reparo',
      subtitle: 'On-demand repair service platform',
      techStack: ['Flutter', 'REST API', 'Booking Flow', 'Service Management'],
      tag: 'Service',
      imageUrl:
          'https://res.cloudinary.com/dn2lldb4m/image/upload/v1773484368/app_logo_j9moac.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.gentleman.app&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/us/app/reparo/id6756050921',
      accent: AppColors.borderDark,
    ),
    ProjectItem(
      title: 'Dragon Math',
      subtitle: 'Interactive math learning app',
      techStack: ['Flutter', 'REST API', 'Interactive UI', 'Progress Flow'],
      tag: 'Education',
      imageUrl:
          'https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?auto=format&fit=crop&w=600&q=80',
      appStoreUrl: 'https://apps.apple.com/us/app/dragon-ma%CE%B8/id6759892711',
      accent: AppColors.primary,
    ),
    ProjectItem(
      title: 'Humdam Flutter',
      subtitle: 'Mobile e-commerce experience',
      techStack: ['Flutter', 'REST API', 'Cart & Checkout', 'Product UI'],
      tag: 'Commerce',
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=600&q=80',
      accent: AppColors.primaryHover,
    ),
    ProjectItem(
      title: 'Pet Team',
      subtitle: 'Pet care service platform',
      techStack: ['Flutter', 'REST API', 'Marketplace Flow', 'Booking'],
      tag: 'Pets',
      imageUrl:
          'https://res.cloudinary.com/dn2lldb4m/image/upload/v1773484311/logo_bulabs.png',
      accent: AppColors.borderDark,
    ),
    ProjectItem(
      title: 'School Point',
      subtitle: 'School event reward system',
      techStack: ['Flutter', 'GetX', 'REST API', 'Reward Logic'],
      tag: 'Education',
      imageUrl:
          'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/school-point',
      accent: AppColors.primary,
    ),
    ProjectItem(
      title: 'Infix',
      subtitle: 'Learning management system app',
      techStack: ['Flutter', 'GetX', 'REST API', 'LMS Workflows'],
      tag: 'LMS',
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/infix-lms',
      accent: AppColors.borderDark,
    ),
    ProjectItem(
      title: 'Call YOU',
      subtitle: 'Video calling application',
      techStack: ['Flutter', 'GetX', 'REST API', 'Calling Flow'],
      tag: 'Video',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/call-you',
      accent: AppColors.primary,
    ),
    ProjectItem(
      title: 'Kunduli Match',
      subtitle: 'Social matching application',
      techStack: ['Flutter', 'GetX', 'REST API', 'Profile Matching'],
      tag: 'Social',
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/kunduli-match',
      accent: AppColors.primaryHover,
    ),
    ProjectItem(
      title: 'Yopo',
      subtitle: 'Tenant management app',
      techStack: ['Flutter', 'GetX', 'REST API', 'Property Workflows'],
      tag: 'Property',
      imageUrl:
          'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/yopo',
      accent: AppColors.borderDark,
    ),
    ProjectItem(
      title: 'Task Management',
      subtitle: 'Team workflow and tracking app',
      techStack: ['Flutter', 'GetX', 'REST API', 'Productivity'],
      tag: 'Productivity',
      imageUrl:
          'https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/task-management',
      accent: AppColors.primary,
    ),
    ProjectItem(
      title: 'Romain Institute School Bill',
      subtitle: 'School billing management app',
      techStack: ['Flutter', 'GetX', 'REST API', 'Billing Workflow'],
      tag: 'Education',
      imageUrl:
          'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?auto=format&fit=crop&w=600&q=80',
      linkUrl: 'https://hridoysoft.com/projects/romain-institute-school-bill',
      accent: AppColors.primaryHover,
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
            final cardWidth = sizingInfo.isMobile
                ? 280.0
                : sizingInfo.isTablet
                ? 280.0
                : 300.0;
            final cardHeight = sizingInfo.isMobile
                ? 320.0
                : sizingInfo.isTablet
                ? 320.0
                : 320.0;

            const firstRowCount = 6;
            final firstRow = _projects.take(firstRowCount).toList();
            final secondRow = _projects.skip(firstRowCount).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'GitHub-driven case studies with focused descriptions and tech stacks.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 24),
                AutoScrollRow(
                  items: firstRow,
                  direction: ScrollDirection.leftToRight,
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                ),
                const SizedBox(height: 20),
                AutoScrollRow(
                  items: secondRow,
                  direction: ScrollDirection.rightToLeft,
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.techStack,
    required this.imageUrl,
    required this.tag,
    required this.accent,
    this.linkUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  final String title;
  final String subtitle;
  final List<String> techStack;
  final String? linkUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String imageUrl;
  final String tag;
  final Color accent;
}

enum ScrollDirection { leftToRight, rightToLeft }

class AutoScrollRow extends StatefulWidget {
  const AutoScrollRow({
    super.key,
    required this.items,
    required this.direction,
    required this.cardWidth,
    required this.cardHeight,
    this.speed = 40,
  });

  final List<ProjectItem> items;
  final ScrollDirection direction;
  final double cardWidth;
  final double cardHeight;
  final double speed;

  @override
  State<AutoScrollRow> createState() => _AutoScrollRowState();
}

class _AutoScrollRowState extends State<AutoScrollRow>
    with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  late final Ticker _ticker;
  Duration? _lastTick;
  double _loopExtent = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _updateLoopExtent();
      _ticker.start();
    });
  }

  @override
  void didUpdateWidget(covariant AutoScrollRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLoopExtent();
  }

  void _updateLoopExtent() {
    if (!_controller.hasClients) {
      return;
    }
    final maxExtent = _controller.position.maxScrollExtent;
    _loopExtent = maxExtent > 0 ? maxExtent / 2 : 0;
  }

  void _onTick(Duration elapsed) {
    if (!mounted || !_controller.hasClients) return;
    if (_isPaused) {
      _lastTick = elapsed;
      return;
    }
    if (_loopExtent == 0) {
      _updateLoopExtent();
      return;
    }
    if (_lastTick == null) {
      _lastTick = elapsed;
      return;
    }

    final deltaSeconds = (elapsed - _lastTick!).inMicroseconds / 1e6;
    _lastTick = elapsed;
    final directionFactor = widget.direction == ScrollDirection.leftToRight
        ? 1.0
        : -1.0;
    var nextOffset =
        _controller.offset + directionFactor * widget.speed * deltaSeconds;
    if (_loopExtent > 0) {
      nextOffset %= _loopExtent;
      if (nextOffset < 0) {
        nextOffset += _loopExtent;
      }
    }

    _controller.jumpTo(nextOffset);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [...widget.items, ...widget.items];
    return MouseRegion(
      onEnter: (_) => setState(() => _isPaused = true),
      onExit: (_) => setState(() => _isPaused = false),
      child: Listener(
        onPointerDown: (_) => setState(() => _isPaused = true),
        onPointerUp: (_) => setState(() => _isPaused = false),
        onPointerCancel: (_) => setState(() => _isPaused = false),
        child: SizedBox(
          height: widget.cardHeight,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == items.length - 1 ? 0 : 20,
                ),
                child: SizedBox(
                  width: widget.cardWidth,
                  height: widget.cardHeight,
                  child: ProjectCard(project: items[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectItem project;

  List<_ProjectAction> get _actions {
    final actions = <_ProjectAction>[];
    if (project.playStoreUrl != null) {
      actions.add(
        _ProjectAction(label: 'Play Store', url: project.playStoreUrl!),
      );
    }
    if (project.appStoreUrl != null) {
      actions.add(
        _ProjectAction(label: 'App Store', url: project.appStoreUrl!),
      );
    }
    if (project.linkUrl != null) {
      actions.add(_ProjectAction(label: 'View Project', url: project.linkUrl!));
    }
    return actions;
  }

  String? get _availabilityNote {
    if (project.playStoreUrl != null && project.appStoreUrl == null) {
      return 'App Store: N/A';
    }
    if (project.appStoreUrl != null && project.playStoreUrl == null) {
      return 'Play Store: N/A';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.12 : 0.06),
                blurRadius: isHovered ? 18 : 12,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ProjectPreview(project: project),
                const SizedBox(height: 12),
                Text(
                  project.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.4,
                    color: project.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.techStack
                      .map(
                        (tech) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.chipLight,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                if (_actions.isEmpty)
                  Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.chipLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Private Project',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  )
                else
                  _ProjectActions(actions: _actions, accent: project.accent),
                if (_availabilityNote != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _availabilityNote!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectAction {
  const _ProjectAction({required this.label, required this.url});

  final String label;
  final String url;
}

class _ProjectActions extends StatelessWidget {
  const _ProjectActions({required this.actions, required this.accent});

  final List<_ProjectAction> actions;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    if (actions.length == 1) {
      return SizedBox(
        width: double.infinity,
        child: _ProjectActionButton(action: actions.first, accent: accent),
      );
    }

    if (actions.length == 2) {
      return Row(
        children: [
          Expanded(
            child: _ProjectActionButton(action: actions[0], accent: accent),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ProjectActionButton(action: actions[1], accent: accent),
          ),
        ],
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: actions
          .map((action) => _ProjectActionButton(action: action, accent: accent))
          .toList(),
    );
  }
}

class _ProjectActionButton extends StatelessWidget {
  const _ProjectActionButton({required this.action, required this.accent});

  final _ProjectAction action;
  final Color accent;

  Future<void> _openLink() async {
    final uri = Uri.parse(action.url);
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openLink,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          action.label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                project.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.chipLight,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.apps_rounded,
                      size: 32,
                      color: project.accent,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.35),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Text(
                project.tag,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
