# Mappy 2

The original [Mappy app](https://github.com/sunderee/Mappy), 16 months later. The app was developed to showcase the use of Mapbox in Flutter apps.

## Usage

This documentation will explain the necessary steps to get the application up and running on respective platforms, Android and iOS (coming soon). In both cases, you need to gather appropriate credentials, these are the **public** and **private** (or _secret_) tokens.

1. Secret token needs to have `Downloads:Read` scope
2. Public token is usually the _default public token_, or a newly generated token marked as public

For more information, you can read documentation for [Android](https://docs.mapbox.com/android/maps/guides/install/) (iOS documentation is coming soon).

### Running the app

You need to provide the public token via `--dart-define`

```bash
flutter run --dart-define=ACCESS_TOKEN=<public-access-token>
```