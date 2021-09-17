String getCurrentTime() {
  var now = new DateTime.now();
  var year = '${now.year}';
  var month = now.month >= 10 ? '${now.month}' : '0${now.month}';
  var day = now.day >= 10 ? '${now.day}' : '0${now.day}';
  return '$year. $month. $day';
}
