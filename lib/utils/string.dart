import 'package:quiver/strings.dart' as quiver;

extension StringExt on String? {
  bool get isBlank => quiver.isBlank(this);
  bool get isNotBlank => quiver.isNotBlank(this);
}