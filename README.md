Article Explorer
Article Explorer is a Flutter app that allows users to explore and read the most popular articles in New York Times. The app is built in MVVM architecture.

Getting Started
Follow the steps below to set up and run the Article Explorer app on your local machine.

Prerequisites
Make sure you have the following tools installed on your machine:

Flutter SDK
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/your-username/article_explorer.git
Change into the project directory:

bash
Copy code
cd article_explorer
Install dependencies:

bash
Copy code
flutter pub get
Running the App
To run the app on a connected device or emulator, use the following command:

bash
Copy code
flutter run
Running Tests
To execute unit tests and generate coverage reports, run the following command:

bash
Copy code
flutter test --coverage
The coverage report will be generated in the coverage/lcov.info file.

Viewing Coverage Report
To view the coverage report in a more human-readable format, you can use the lcov tool.

Notes
The tests include unit tests for the ViewModel and Widget tests using flutter_test and mocktail packages.
The ArticlesViewModel class is tested separately using mock services to ensure proper functionality.
Widget tests cover UI elements and interactions to validate the app's behavior.
The coverage report helps you assess the test coverage for your app.
