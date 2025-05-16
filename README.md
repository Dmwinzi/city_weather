# city_weather

A clean, modern Flutter mobile app for Android and iOS that displays current weather and a 5-day forecast using the OpenWeather API. Built with performance, usability, and offline support in mind.

## Features
- Search for any city and get real-time weather updates
- 5-day forecast with daily breakdowns
- Offline support with local caching
- Fully responsive UI with clean, modern design

## ⚠️ Note 

For the purpose of this interview/demo, a dummy list of cities is used in place of a full global city dataset.  
These cities are compatible with OpenWeather's API. In a production app, this would be replaced with a proper database, asset file, or third-party API (like GeoDB or OpenWeather’s city list).

This approach helps demonstrate the app’s functionality without depending on external services during evaluation.

## Prerequisites
- Flutter SDK installed
- Internet connection for fetching weather data
- OpenWeather API key as env variable


## Approach
Used a clean, modular architecture for maintainability and clarity.

Integrated OpenWeather API to fetch both current and forecast data.

Designed a modern, responsive UI using Lottie animations and adaptive sizing.

Built a custom bottom sheet with real-time search for cities from a dummy list.

Ensured offline support through local data caching.

## challenges
No access to a full global city database - soln Used a static list of known OpenWeather-compatible cities for demonstration.
mockito resolving some parameter as null

## Getting Started

```bash
git clone https://github.com/Dmwinzi/city_weather
cd city_weather
flutter pub get
flutter run
