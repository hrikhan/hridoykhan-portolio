import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/hover.dart';
import '../../../core/widgets/link_text.dart';
import '../../../core/widgets/responsive_builder.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const List<_ContactInfoItem> _infoItems = [
    _ContactInfoItem(
      icon: Icons.email_outlined,
      label: 'Email',
      value: 'hridoykhan.cse.cu@gmail.com',
      link: 'mailto:hridoykhan.cse.cu@gmail.com',
    ),
    _ContactInfoItem(
      icon: Icons.phone_outlined,
      label: 'Phone',
      value: '01779799197',
      link: 'tel:+8801779799197',
    ),
  ];

  static const List<_SocialLink> _socialLinks = [
    _SocialLink(label: 'GitHub', url: 'https://github.com/hrikhan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: Color(0xFF24313C))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: ResponsiveBuilder(
            builder: (context, sizingInfo) {
              final isDesktop = sizingInfo.isDesktop;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: _ContactInfo(
                            infoItems: _infoItems,
                            socialLinks: _socialLinks,
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(child: _ContactFormCard()),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _ContactInfo(
                          infoItems: _infoItems,
                          socialLinks: _socialLinks,
                        ),
                        SizedBox(height: 28),
                        _ContactFormCard(),
                      ],
                    ),
                  const SizedBox(height: 32),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 1,
                  ),
                  const SizedBox(height: 18),
                  const _ContactFooter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContactInfoItem {
  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.link,
  });

  final IconData icon;
  final String label;
  final String value;
  final String link;
}

class _SocialLink {
  const _SocialLink({required this.label, required this.url});

  final String label;
  final String url;
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({required this.infoItems, required this.socialLinks});

  final List<_ContactInfoItem> infoItems;
  final List<_SocialLink> socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Let's Discuss Your Project",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Have an idea for a mobile app? I am currently available for '
          'freelance work and open to new opportunities.',
          style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFFB7C4D1)),
        ),
        const SizedBox(height: 24),
        ...infoItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ContactInfoRow(item: item),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'SOCIALS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Color(0xFF8FA2B4),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: socialLinks
              .map(
                (link) => LinkText(
                  label: link.label,
                  url: link.url,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  hoverColor: AppColors.primary,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ContactInfoRow extends StatelessWidget {
  const _ContactInfoRow({required this.item});

  final _ContactInfoItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: Icon(item.icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8FA2B4),
              ),
            ),
            const SizedBox(height: 4),
            LinkText(
              label: item.value,
              url: item.link,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              hoverColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactFormCard extends StatefulWidget {
  const _ContactFormCard();

  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  static const String _emailJsEndpoint =
      'https://api.emailjs.com/api/v1.0/email/send';

  final String _emailJsServiceId = _envOrEmpty('EMAILJS_SERVICE_ID');
  final String _emailJsTemplateId = _envOrEmpty('EMAILJS_TEMPLATE_ID');
  final String _emailJsPublicKey = _envOrEmpty('EMAILJS_PUBLIC_KEY');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  static String _envOrEmpty(String key) {
    try {
      return dotenv.isInitialized ? dotenv.env[key] ?? '' : '';
    } catch (_) {
      return '';
    }
  }

  bool get _emailJsConfigured =>
      _emailJsServiceId.isNotEmpty &&
      _emailJsTemplateId.isNotEmpty &&
      _emailJsPublicKey.isNotEmpty;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void _showSnackBar(String message, {bool success = false}) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.primary : Colors.red.shade600,
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_isSending) {
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnackBar('Please fill in name, email, and message.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar('Please enter a valid email address.');
      return;
    }

    if (!_emailJsConfigured) {
      _showSnackBar('Email service is not configured yet.');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.post(
        Uri.parse(_emailJsEndpoint),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _emailJsServiceId,
          'template_id': _emailJsTemplateId,
          'user_id': _emailJsPublicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'subject': subject.isEmpty ? 'New contact request' : subject,
            'message': message,
            'reply_to': email,
          },
        }),
      );

      if (!mounted) {
        return;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
        _showSnackBar('Message sent successfully.', success: true);
      } else {
        _showSnackBar('Failed to send message. Please try again.');
      }
    } catch (_) {
      if (!mounted) {
        return;
      }
      _showSnackBar('Failed to send message. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16212A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF24313C)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          final isMobile = sizingInfo.isMobile;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                _LabeledField(
                  label: 'Name',
                  hintText: 'John Doe',
                  controller: _nameController,
                ),
              if (isMobile) const SizedBox(height: 16),
              if (isMobile)
                _LabeledField(
                  label: 'Email',
                  hintText: 'john@company.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              if (!isMobile)
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'Name',
                        hintText: 'John Doe',
                        controller: _nameController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _LabeledField(
                        label: 'Email',
                        hintText: 'john@company.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              _LabeledField(
                label: 'Subject',
                hintText: 'Project Inquiry',
                controller: _subjectController,
              ),
              const SizedBox(height: 16),
              _LabeledField(
                label: 'Message',
                hintText: 'Tell me about your project...',
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                controller: _messageController,
              ),
              const SizedBox(height: 20),
              _SendButton(isSending: _isSending, onTap: _sendMessage),
            ],
          );
        },
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  final String label;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9EB0C1),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF6E8091)),
            filled: true,
            fillColor: const Color(0xFF101922),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF24313C)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF24313C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.isSending, required this.onTap});

  final bool isSending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      cursor: isSending ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isHovered) {
        final Color backgroundColor;
        if (isSending) {
          backgroundColor = AppColors.primary.withValues(alpha: 0.7);
        } else {
          backgroundColor = isHovered
              ? AppColors.primaryHover
              : AppColors.primary;
        }

        return GestureDetector(
          onTap: isSending ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isSending ? 'Sending...' : 'Send Message',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                if (isSending)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContactFooter extends StatelessWidget {
  const _ContactFooter();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        final isMobile = sizingInfo.isMobile;
        final copyright = Text(
          '© 2025 Hridoy Khan. All rights reserved.',
          style: const TextStyle(fontSize: 12, color: Color(0xFF8FA2B4)),
        );
        final links = Wrap(
          spacing: 16,
          runSpacing: 8,
          children: const [
            LinkText(
              label: 'Privacy Policy',
              url: 'https://example.com/privacy',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8FA2B4),
              hoverColor: AppColors.primary,
            ),
            LinkText(
              label: 'Terms of Service',
              url: 'https://example.com/terms',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8FA2B4),
              hoverColor: AppColors.primary,
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [copyright, const SizedBox(height: 8), links],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            copyright,
            Flexible(
              child: Align(alignment: Alignment.centerRight, child: links),
            ),
          ],
        );
      },
    );
  }
}
