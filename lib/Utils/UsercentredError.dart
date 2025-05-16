String getUserFriendlyErrorMessage(String error) {
  if (error.contains('SocketException')) {
    return 'No internet connection. Please check your network.';
  } else if (error.contains('timeout')) {
    return 'The request timed out. Please try again later.';
  } else if (error.contains('404')) {
    return 'City not found. Please check the city name.';
  } else {
    return 'An unexpected error occurred. Please try again.';
  }
}