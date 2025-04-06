const List<String> _dayNames = [
  'Minggu',
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
];

const List<String> _monthNames = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

extension DateTimeExt on DateTime {
  String toFormattedDayTime() {
    String dayName = _dayNames[weekday - 1];
    return '$dayName, ${toFormattedTime()}';
  }

  String toFormattedDate() {
    return '$day.$month.$year';
  }

  String toFormattedMonth() {
    return _monthNames[month - 1];
  }

  String toFormattedTimeAgo() {
    Duration difference = DateTime.now().difference(this);
    if (difference.inDays > 30) {
      return toFormattedDate();
    } else if (difference.inDays > 0 && difference.inDays <= 30) {
      return '${difference.inDays} day ago';
    } else if (difference.inHours > 0 && difference.inHours <= 24) {
      return '${difference.inHours} hour ago';
    } else if (difference.inMinutes > 0 && difference.inMinutes <= 60) {
      return '${difference.inMinutes} minute ago';
    } else if (difference.inSeconds > 0 && difference.inSeconds <= 60) {
      return '${difference.inSeconds} second ago';
    } else {
      return 'now';
    }
  }

  String toFormattedTime() {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute WIB';
  }
}
