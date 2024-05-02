
# coding_challenge Codebase

### Source code of the coding_challenge app for Android and IOS

(https://github.com/sylensa/coding_challenge.git)

## Tech Stack

Listed below are the tech stack used in the flutter application:

- [Rest Apis](https://excelliumgh.com/cdn/syl/) - This provides the necessary endpoints for fetching data etc.
- SharedPreferences -Used for persisting user data where needed
- GetX and MVC Architecture - Used for state management

## Running The App

#### `NB: This app has been imported to null-safety. Therefore, to run the app with no dependency conflicts and issues, you need to install flutter sdk version between '>=3.3.0 <4.0.0' to run the app.`

.

##### Steps

1. Clone the repo
   With ssh

    ```sh
    git@github.com:sylensa/coding_challenge.git
    ```

   With https

    ```sh
    https://github.com/sylensa/coding_challenge.git
    ```

#### `NB: The most up to date branch is master`

2. Run: `flutter pub get` to get the packages and dependencies setup/installed
3. Run the app using `flutter run lib/main.dart` to run the app.

Useful Resources:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter online documentation](https://flutter.dev/docs) - which offers tutorials,
  samples, guidance on mobile development, and a full API reference.

### Code Architecture

This codebase uses some 'form' of clean architecture which separates the three main layers namely:

1. Data layer (Model) - Implementation of the domain model interfaces 
2. The Domain layer (View) - Usually made up of interfaces and domain models
3. Controller - Business logic etc.

| Folder Name | Description |
| ----- | ------ |
| assets | Contains all assets used in the app. Assets can be grouped into fonts, images, icons etc.|
| android | Contains android specific files and configurations |
| ios | Conains ios specific files and configurations |
| lib | This is the main folder which usually contains shared code used on multiple platforms. Expanding further, lib contains the folders listed below:|

[` lib `](/lib)  Folder structure
| Folder Name | Description |
| ----- | ------ |
| core | Contains all configurations like button styles, text styles, global color declarations, enums, constants etc. used in the app.|
| feature | Contains all Main UI with sub folders such as Models, Views and Controller used in the app.|

