import 'dart:io';
import 'package:intl/intl.dart';

final _dayMonthYearDottedFormatter = DateFormat('d.M.y', Platform.localeName);
final _dayMonthWordFormatter = DateFormat('d MMMM', Platform.localeName);
final _timeFormatter = DateFormat.Hm();

extension Format on DateTime {
  String get dayMonthYearDottedFormat =>
      _dayMonthYearDottedFormatter.format(this);

  String get dayMonthWordFormat =>
      _dayMonthWordFormatter.format(this);

  String get timeFormat =>
      _timeFormatter.format(this);
}
