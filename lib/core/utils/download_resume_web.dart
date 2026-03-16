// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadResumeImpl(String path, {String? fileName}) async {
  final anchor = html.AnchorElement(href: path)
    ..download = fileName ?? path.split('/').last
    ..style.display = 'none';

  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}
