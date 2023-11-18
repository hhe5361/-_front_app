String formatMilliseconds(int milliseconds) {
  // 총 밀리세컨드를 초로 변환
  int totalSeconds = (milliseconds / 1000).floor();

  // 시간, 분, 초 계산
  int hours = (totalSeconds ~/ 3600).floor();
  int minutes = ((totalSeconds % 3600) ~/ 60).floor();
  int seconds = (totalSeconds % 60);

  String formattedTime =
      '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';

  return formattedTime;
}

String _twoDigits(int n) {
  // 숫자를 두 자리 문자열로 변환
  if (n >= 10) {
    return '$n';
  } else {
    return '0$n';
  }
}
