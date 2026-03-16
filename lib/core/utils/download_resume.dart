import 'download_resume_stub.dart'
    if (dart.library.html) 'download_resume_web.dart';

Future<void> downloadResume(String path, {String? fileName}) {
  return downloadResumeImpl(path, fileName: fileName);
}
