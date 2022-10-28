# Cetasol troubleshoot / guide app prototype
A project made to test if a troubleshoot / guide app targeted for Cetasols iHelm solution can help the customer onboarding process.
The app is coded in Dart using Flutter as framework, and has been worked on for ~5 weeks.
Project development is currenly on a pause.

App uses the following Firebase services:
- Firestore cloud database - Used for storing user information
- Firestore authentication - Used for the sign up process to authenticate real users using phone number as verification.
- Firestore storage - Used for storing user images.

# Installation
I recommend going through [Flutters installation guide](https://docs.flutter.dev/get-started/install) on how to get started.
The steps in that guide will look roughly like this:

1. Install Flutter SDk
2. Update your PATH variable 
3. Install Android studio or xCode and setup phone simulator
4. Install Flutter and Dart plugins in VS Code
5. Validate your setup with Flutter Doctor
#
After flutter doctor command returns with no errors, then go ahead and clone the repository:
```
git clone https://github.com/Mattias170624/Cetasol_App.git
```
Run the following command in project root to get the required dependencies:
```
flutter pub get
```
#
The app uses an API_KEY variable in order to fetch youtube videos, this variable is included in .gitIgnore so you will have to just
replace the variable with an empty string and remove the import to the hidden file.

File is located in /lib/Widgets/YoutubeServices/api_service.dart
