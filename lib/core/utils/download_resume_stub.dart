import 'package:url_launcher/url_launcher.dart';

Future<void> downloadResumeImpl(String path, {String? fileName}) async {
  final uri = Uri.parse(path);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
