# How to build and publish

## Build
- Install [Flutter](https://docs.flutter.dev/get-started/install)
- Clone repo
To make sure the flutter installed run
- run `flutter doctor -v`
- `flutter pub get` to install dependencies
- `flutter pub run build_runner build --delete-conflicting-outputs` to generate files
- `flutter run` or start debug session in your IDE


## Release
 - [iOS](https://docs.flutter.dev/deployment/ios)
 - [Android](https://docs.flutter.dev/deployment/android)

## Testing

There is not auto tests
To share app with your tester use this:
- [Testflight](https://docs.flutter.dev/deployment/ios#release-your-app-on-testflight) for iOS
- `flutter build apk --release` to build apk


