# Mappy 2

Remake and slight overhaul of the [Mappy app](https://github.com/sunderee/Mappy), 16 months later, which was developed to showcase the integration of Mapbox in Flutter. Currently, it's only available for Android, as I'm waiting for my new MacBook Pro to arrive 🤦. I will update the project in the future, I promise.

## Usage

This documentation will explain the necessary steps to get the application up and running on respective platforms, Android and iOS (coming soon). In both cases, you need to gather appropriate credentials, these are the **public** and **private** (or _secret_) tokens.

1. Secret token needs to have `Downloads:Read` scope
2. Public token is usually the _default public token_, or a newly generated token marked as public

### Android

Create a `gradle.properties` file in Gradle user home folder (typically `USER_HOME/.gradle`) with the following contents:

```bash
MAPBOX_DOWNLOADS_TOKEN=YOUR_SECRET_MAPBOX_ACCESS_TOKEN
```

Next, copy the public token somewhere accessible, for example, in `android/app/src/main/res/values/strings.xml` (this file is mentioned in `android/.gitignore` for this particular reason)

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="mapbox_access_token">YOUR_MAPBOX_ACCESS_TOKEN</string>
</resources>
```

Obviously you don't need to do it this way, but just find a way to keep the public (access) token somewhere handy.

### Running the app

Start by installing dependencies and running the code generation task

```bash
flutter pub get
flutter pub run build_runner build
```

To run the app, provide the public access token via `--dart-define`

```bash
flutter run --dart-define=ACCESS_TOKEN=<public-access-token>
```

You can use the trivial unit test to check if points of interest are fetched correctly from Mapbox's Search API

```bash
flutter test --dart-define=ACCESS_TOKEN=<public-access-token>
```

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/sunderee)
