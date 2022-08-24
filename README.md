# How to build and publish

## Build 
- Install [Flutter](https://docs.flutter.dev/get-started/install)
- Clone repo
- run `flutter doctor -v` to check if there are any issues with your platforms
- `flutter pub get` to install dependencies
- `flutter pub run build_runner build --delete-conflicting-outputs` to generate files
- create `.env` file with two lines **(new)**
```
DOMAIN=https://your_domain_here.com
API_DOMAIN=https://your_api_domain.com
```
- `flutter run` or start debug session in your IDE


## Release
 - [iOS](https://docs.flutter.dev/deployment/ios)
 - [Android](https://docs.flutter.dev/deployment/android)

## Testing

There is not auto tests
To share app with your tester use this:
- [Testflight](https://docs.flutter.dev/deployment/ios#release-your-app-on-testflight) for iOS
- `flutter build apk --release` to build apk


