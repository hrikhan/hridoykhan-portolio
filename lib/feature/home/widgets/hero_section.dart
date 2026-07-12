import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../core/utils/download_resume.dart';
import '../../../core/widgets/hover.dart';
import '../../../core/widgets/responsive_builder.dart';
import '../controller/home_controller.dart';
import 'navbar.dart';
import 'tech_stack_chips.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        final isMobile = sizingInfo.isMobile;
        final isTablet = sizingInfo.isTablet;
        final titleSize = isMobile ? 32.0 : isTablet ? 42.0 : 54.0;

        final content = _HeroContent(
          titleSize: titleSize,
          isMobile: isMobile,
          onPrimaryTap: () =>
              controller.scrollToSection(controller.projectsKey, offset: 72),
          onResumeTap: () {
            downloadResume(
              'resume/hridoy-khan-cv.pdf',
              fileName: 'Hridoy-Khan-CV.pdf',
            );
          },
        );

        final visual = _HeroVisual(
          alignment: sizingInfo.isDesktop
              ? Alignment.centerRight
              : Alignment.center,
          showCodeOverlay: true,
          isMobile: isMobile,
        );

        return Stack(
          children: [
            const Positioned.fill(
              child: _HeroVideoPlayer(),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.65),
                      Colors.white.withValues(alpha: 0.75),
                      AppColors.backgroundLight.withValues(alpha: 0.80),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Padding(
                  padding: Breakpoints.pagePadding(sizingInfo.deviceType).copyWith(
                    top: sizingInfo.isDesktop ? (Navbar.height + 80) : (Navbar.height + 48),
                    bottom: sizingInfo.isDesktop ? 80 : 48,
                  ),
                  child: sizingInfo.isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: content),
                            const SizedBox(width: 80),
                            visual,
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            visual,
                            const SizedBox(height: 32),
                            content,
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.titleSize,
    required this.isMobile,
    required this.onPrimaryTap,
    required this.onResumeTap,
  });

  final double titleSize;
  final bool isMobile;
  final VoidCallback onPrimaryTap;
  final VoidCallback onResumeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AnimatedTitle(titleSize: titleSize),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                AppColors.textPrimary,
                Color(0xFF5A6B7C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'I design and ship Flutter applications that combine polished UI, '
              'maintainable architecture, and dependable integrations. My work '
              'covers Android, iOS, and web experiences with hands-on delivery in '
              'state management, REST APIs, local storage, Firebase services, and '
              'AI-assisted product features. I focus on building software that is '
              'fast, scalable, and genuinely useful for real users.',
              textAlign: TextAlign.justify,
              style: GoogleFonts.raleway(
                fontSize: isMobile ? 14 : 16,
                height: 1.7,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.white, // Colors.white is required for ShaderMask to apply the gradient properly
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.02),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _PrimaryButton(
              icon: Icons.visibility,
              label: 'View My Work',
              onTap: onPrimaryTap,
            ),
            _OutlineButton(
              icon: Icons.download,
              label: 'Download Resume',
              onTap: onResumeTap,
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Text(
          'TECH STACK',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.8,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 12),
        const TechStackChips(),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: isHovered ? AppColors.primaryHover : AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            transform: Matrix4.translationValues(0, isHovered ? -2 : 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 2,
                color: isHovered ? AppColors.primary : AppColors.borderLight,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isHovered ? AppColors.primary : AppColors.textPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isHovered
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedTitle extends StatefulWidget {
  const _AnimatedTitle({required this.titleSize});

  final double titleSize;

  @override
  State<_AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<_AnimatedTitle> {
  static const Duration _displayDuration = Duration(milliseconds: 2200);
  static const Duration _switchDuration = Duration(milliseconds: 520);

  late final List<_AnimatedTitleItem> _items = [
    _AnimatedTitleItem(
      key: 'flutter_engineer',
      spans: const [
        TextSpan(
          text: 'Flutter ',
          style: TextStyle(color: AppColors.backgroundDark),
        ),
        TextSpan(
          text: 'Engineer',
          style: TextStyle(color: AppColors.primary),
        ),
        TextSpan(text: ' for real products'),
      ],
    ),
    _AnimatedTitleItem(
      key: 'multi_platform',
      spans: const [
        TextSpan(text: 'Building '),
        TextSpan(
          text: 'Android',
          style: TextStyle(color: AppColors.primary),
        ),
        TextSpan(text: ' & '),
        TextSpan(
          text: 'iOS',
          style: TextStyle(color: AppColors.primary),
        ),
        TextSpan(text: ' experiences'),
      ],
    ),
    _AnimatedTitleItem(
      key: 'api_driven_apps',
      spans: const [
        TextSpan(text: 'Creating '),
        TextSpan(
          text: 'API-driven',
          style: TextStyle(color: AppColors.primary),
        ),
        TextSpan(text: ' business '),
        TextSpan(
          text: 'apps',
          style: TextStyle(color: AppColors.primary),
        ),
      ],
    ),
    _AnimatedTitleItem(
      key: 'ai_features',
      spans: const [
        TextSpan(text: 'Adding '),
        TextSpan(
          text: 'AI-assisted',
          style: TextStyle(color: AppColors.primary),
        ),
        TextSpan(text: ' product features'),
      ],
    ),
  ];

  int _currentIndex = 0;
  Timer? _timer;

  TextStyle get _baseStyle => GoogleFonts.raleway(
    fontSize: widget.titleSize,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_displayDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _currentIndex = (_currentIndex + 1) % _items.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = _items[_currentIndex];
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;
        final TextDirection textDirection = Directionality.of(context);
        double maxHeight = 0;
        for (final title in _items) {
          final painter = TextPainter(
            text: TextSpan(style: _baseStyle, children: title.spans),
            textDirection: textDirection,
          )..layout(maxWidth: maxWidth);
          if (painter.height > maxHeight) {
            maxHeight = painter.height;
          }
        }

        return Semantics(
          header: true,
          child: SizedBox(
            height: maxHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: _switchDuration,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: const Offset(0, 0.18),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: RichText(
                  key: ValueKey(item.key),
                  textAlign: TextAlign.left,
                  text: TextSpan(style: _baseStyle, children: item.spans),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedTitleItem {
  const _AnimatedTitleItem({required this.key, required this.spans});

  final String key;
  final List<TextSpan> spans;
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({
    required this.alignment,
    required this.showCodeOverlay,
    required this.isMobile,
  });

  final Alignment alignment;
  final bool showCodeOverlay;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final visualSize = maxWidth > 520 ? 520.0 : maxWidth;
          return SizedBox(
            width: visualSize,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  const Positioned.fill(child: _HeroGlow()),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                'https://res.cloudinary.com/dofsibxao/image/upload/v1766552671/2025-12-24_10.59.56_jksifr.jpg',
                                fit: BoxFit.cover,
                                alignment: const Alignment(0, -0.22),
                                filterQuality: FilterQuality.medium,
                              ),
                            ),
                            if (showCodeOverlay)
                              Positioned(
                                top: 10,
                                right: 24,
                                child: _CodeOverlay(
                                  backgroundOpacity: isMobile ? 0.7 : 0.9,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroVideoPlayer extends StatefulWidget {
  const _HeroVideoPlayer();

  @override
  State<_HeroVideoPlayer> createState() => _HeroVideoPlayerState();
}

class _HeroVideoPlayerState extends State<_HeroVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/286278_small.mp4');
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _initialized = true;
        });
        _controller.setLooping(true);
        _controller.setVolume(0.0); // Mute is required for web autoplay
        _controller.play();
      }
    }).catchError((e) {
      debugPrint('Video player initialization error: $e');
      if (mounted) {
        setState(() {
          _error = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const _FallbackImage();
    }

    if (!_initialized) {
      return Container(
        color: AppColors.backgroundLight,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}

class _FallbackImage extends StatelessWidget {
  const _FallbackImage();

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://res.cloudinary.com/dofsibxao/image/upload/v1766552671/2025-12-24_10.59.56_jksifr.jpg',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
    );
  }
}

class _HeroGlow extends StatelessWidget {
  const _HeroGlow();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 1.2,
        heightFactor: 1.2,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeOverlay extends StatelessWidget {
  const _CodeOverlay({required this.backgroundOpacity});

  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(backgroundOpacity),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF38424F)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              _Dot(color: Color(0xFFEF4444)),
              SizedBox(width: 6),
              _Dot(color: Color(0xFFFACC15)),
              SizedBox(width: 6),
              _Dot(color: Color(0xFF22C55E)),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
                color: Color(0xFFCBD5E1),
              ),
              children: const [
                TextSpan(
                  text: 'class ',
                  style: TextStyle(color: Color(0xFFC792EA)),
                ),
                TextSpan(
                  text: 'MyApp ',
                  style: TextStyle(color: Color(0xFFFFCB6B)),
                ),
                TextSpan(
                  text: 'extends ',
                  style: TextStyle(color: Color(0xFFC792EA)),
                ),
                TextSpan(
                  text: 'StatelessWidget',
                  style: TextStyle(color: Color(0xFFFFCB6B)),
                ),
                TextSpan(text: ' {\n'),
                TextSpan(
                  text: '  @override\n',
                  style: TextStyle(color: Color(0xFFC792EA)),
                ),
                TextSpan(
                  text: '  Widget ',
                  style: TextStyle(color: Color(0xFFFFCB6B)),
                ),
                TextSpan(
                  text: 'build',
                  style: TextStyle(color: Color(0xFF82AAFF)),
                ),
                TextSpan(text: '() {\n'),
                TextSpan(
                  text: '    return ',
                  style: TextStyle(color: Color(0xFFC792EA)),
                ),
                TextSpan(
                  text: 'Container',
                  style: TextStyle(color: Color(0xFFFFCB6B)),
                ),
                TextSpan(text: '(\n'),
                TextSpan(
                  text: '      child: ',
                  style: TextStyle(color: Color(0xFF82AAFF)),
                ),
                TextSpan(
                  text: '"Success"',
                  style: TextStyle(color: Color(0xFFC3E88D)),
                ),
                TextSpan(text: ',\n'),
                TextSpan(text: '    );\n'),
                TextSpan(text: '  }\n'),
                TextSpan(text: '}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
