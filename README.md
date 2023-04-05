# Coolors Clone
A clone of coolors mobile application(android/ios) made with flutter. 
Education purpose only, not for commercial.

## Key Features

 - Tap to generate color palette.
 - Shake! to generate color palette.
 - Copy color hex code.
 - Drap and drop color to change order in color palette.
 - Lock individual color to keep same color when generating.
 - Undo/Redo color palette generator.
 - Pick color with color plate, hex code, hsv, hsl, material color and saved colors.
 - Save color and color palette in account.
 - Browse through color palette libraray, apply or save color palette from library.

- [iOS app](https://apps.apple.com/us/app/coolors-clone/id1667069377)
- [Android app](https://play.google.com/store/apps/details?id=dev.khanin.coolors_inspired_flutter)

## Key Technical implementation

- Reorderable flexible list view.
- Statemanagement with Riverpod.
- Undo/Redo implemenation with mixin and Riverpod.
- Random color with [random_color](https://pub.dev/packages/random_color) package.
- Shake listener with [shake](https://pub.dev/packages/shake) package.
- Authentication with Firebase authentication. Google sing-in and Apple sign-in.
- Firebase Firestore as real-time database.
- Parse and display color between string and hex code.
- Multi-level of Navigation with ModalBottomSheet.

