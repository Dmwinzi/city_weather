String getLottieForCondition(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return 'assets/images/cloudy.json';
    case 'clouds':
      return 'assets/images/cloudy.json';
    case 'rain':
      return 'assets/images/rainy.json';
    case 'thunderstorm':
      return 'assets/images/suncloud.json';
    case 'wind':
      return 'assets/images/windy.json';
    case 'sunny':
      return 'assets/images/sunny.json';
    default:
      return 'assets/images/suncloud.json';
  }
}
