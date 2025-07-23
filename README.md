# too_taps

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Platform notes

System-wide touch counting is supported only on Android. On iOS, touch
detection is limited to interactions inside the app.

## AI-generated posts

The app can generate motivational posts using Google's generative AI
services. To enable this feature you must provide a Google API key at
compile time via the `GOOGLE_API_KEY` environment variable.

Example command lines:

```bash
# Run on a connected device
flutter run --dart-define=GOOGLE_API_KEY=YOUR_API_KEY

# Build an APK
flutter build apk --dart-define=GOOGLE_API_KEY=YOUR_API_KEY
```

If no key is supplied, the app falls back to local placeholder messages.

## License

This project is licensed under the terms of the [MIT License](LICENSE).

