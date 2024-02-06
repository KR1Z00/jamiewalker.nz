# jamie_walker_website

A Flutter web app to serve as Jamie Walker's personal portfolio website.

## Getting Started

### 1. Run the code generator

```zsh
dart run build_runner build --delete-conflicting-outputs
```

### 2. Generating the Dart localization key constants

```zsh
dart run easy_localization:generate -S assets/translations -f json -O lib/app/localization/generated -o locale_json.g.dart
dart run easy_localization:generate -S assets/translations -f keys -O lib/app/localization/generated -o locale_keys.g.dart
```

### 3. Initialise Firebase

#### 3.1 Install the Firebase CLI

**Using npm**

```
npm install -g firebase-tools
```

See the following link for more details on the different ways to install firebase-tools:
https://firebaseopensource.com/projects/firebase/firebase-tools/#installation 

#### 3.2 Log in to Firebase

```
firebase login
```

#### 3.3 Install FlutterFire

This is a package that simplifies the integration of Firebase into a Flutter cross-platform app.
To install it globally on your system, use:

```
dart pub global activate flutterfire_cli
```

#### 3.4 Configure Firebase in your local copy of the codebase

```
flutterfire configure
```
