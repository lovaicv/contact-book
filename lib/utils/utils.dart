import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

showLog(dynamic message, {String? tag}) {
  // if (Config.isDebug) log('$message', name: tag ?? 'check');
  if (kDebugMode) printWrapped('${tag != null ? '$tag ' : ''}$message');
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

copy(String? html) async {
  await Clipboard.setData(ClipboardData(text: '$html'));
}
