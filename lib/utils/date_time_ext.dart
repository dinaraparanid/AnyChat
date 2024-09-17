import 'package:intl/intl.dart';

const _locale = 'ru_RU';
final _dayMonthYearDottedFormatter = DateFormat('d.M.y', _locale);
final _dayMonthWordFormatter = DateFormat('d MMMM', _locale);
final _timeFormatter = DateFormat.Hm();

extension Format on DateTime {
  String get dayMonthYearDottedFormat =>
      _dayMonthYearDottedFormatter.format(this);

  String get dayMonthWordFormat =>
      _dayMonthWordFormatter.format(this);

  String get timeFormat =>
      _timeFormatter.format(this);
}
